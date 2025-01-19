//
//  PieChartView.swift
//  BudgetTrackerApp
//
//  Created by Tiko on 18.01.25.
//
import SwiftUI

struct PieChartView: View {
    let data: [Double]
    let labels: [String]
    let colors: [Color]

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                ForEach(0..<data.count, id: \.self) { index in
                    PieSliceView(
                        startAngle: self.angle(for: index, in: data),
                        endAngle: self.angle(for: index + 1, in: data),
                        color: self.colors[index % self.colors.count]
                    )
                }
            }
            .aspectRatio(1, contentMode: .fit)
            .frame(width: geometry.size.width, height: geometry.size.width)
        }
    }
    
    private func angle(for index: Int, in data: [Double]) -> Angle {
        let total = data.reduce(0, +)
        let value = data.prefix(index).reduce(0, +)
        return .degrees((value / total) * 360)
    }
}

struct PieSliceView: View {
    let startAngle: Angle
    let endAngle: Angle
    let color: Color

    var body: some View {
        Path { path in
            let center = CGPoint(x: 0.5, y: 0.5)
            path.move(to: center)
            path.addArc(
                center: center,
                radius: 0.5,
                startAngle: startAngle,
                endAngle: endAngle,
                clockwise: false
            )
        }
        .fill(color)
        .aspectRatio(1, contentMode: .fit)
    }
}
