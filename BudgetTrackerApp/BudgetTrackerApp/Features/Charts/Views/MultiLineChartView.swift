//
//  MultiLineChart.swift
//  BudgetTrackerApp
//
//  Created by Tiko on 20.01.25.
//
//
import SwiftUI

struct MultiLineChartView: View {
    let data: [ComparisonData]
    
    var body: some View {
        GeometryReader { geometry in
            let height = geometry.size.height
            let maxValue = getMaxValue()
            
            ZStack {
                VStack(alignment: .leading, spacing: height / 6) {
                    ForEach(0..<6) { _ in
                        Color.gray.opacity(0.2)
                            .frame(height: 1)
                    }
                }
                
                Group {
                    drawLine(data: data.map { $0.oneYearAgo }, color: .orange, geometry: geometry, maxValue: maxValue)
                    
                    drawLine(data: data.map { $0.twoYearsAgo }, color: .lightBlue, geometry: geometry, maxValue: maxValue)
                    
                    drawLine(data: data.map { $0.present }, color: .brandGreen, geometry: geometry, maxValue: maxValue)
                }
                
                VStack {
                    Spacer()
                    HStack {
                        ForEach(data, id: \.date) { item in
                            Text(item.date)
                                .font(.caption)
                                .foregroundColor(.gray)
                            if item.date != data.last?.date {
                                Spacer()
                            }
                        }
                    }
                    .padding(.top, 8)
                }
            }
        }
    }
    
    private func getMaxValue() -> Double {
        let allValues = data.flatMap { [$0.oneYearAgo, $0.twoYearsAgo, $0.present] }
        return allValues.max() ?? 1
    }
    
    private func drawLine(data: [Double], color: Color, geometry: GeometryProxy, maxValue: Double) -> some View {
        let width = geometry.size.width
        let height = geometry.size.height - 20
        let step = width / CGFloat(data.count - 1)
        
        return Path { path in
            for (index, value) in data.enumerated() {
                let x = CGFloat(index) * step
                let y = height - (CGFloat(value) / CGFloat(maxValue) * height)
                
                if index == 0 {
                    path.move(to: CGPoint(x: x, y: y))
                } else {
                    path.addLine(to: CGPoint(x: x, y: y))
                }
            }
        }
        .stroke(color, style: StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round))
    }
}

struct MultiLineChart_Previews: PreviewProvider {
    static var previews: some View {
        MultiLineChartView(data: MockDashboardData.comparisonData)
            .frame(height: 200)
            .padding()
            .background(Color.white)
    }
}
