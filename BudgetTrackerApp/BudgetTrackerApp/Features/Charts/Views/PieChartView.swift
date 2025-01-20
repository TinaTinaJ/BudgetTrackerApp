//
//  PieChartView.swift
//  BudgetTrackerApp
//
//  Created by Tiko on 18.01.25.
//

import SwiftUI
import Foundation

struct PieSliceView: View {
    let startAngle: Double
    let endAngle: Double
    let color: Color
    
    var body: some View {
        GeometryReader { geometry in
            Path { path in
                let center = CGPoint(x: geometry.size.width / 2, y: geometry.size.height / 2)
                let radius = min(geometry.size.width, geometry.size.height) / 2
                
                path.move(to: center)
                path.addArc(
                    center: center,
                    radius: radius,
                    startAngle: Angle(degrees: startAngle - 90),
                    endAngle: Angle(degrees: endAngle - 90),
                    clockwise: false
                )
                path.closeSubpath()
            }
            .fill(color)
        }
    }
}

struct PieChartView: View {
    let data: [Double]
    let labels: [String]
    let colors: [Color]
    let showLabels: Bool
    
    init(data: [Double], labels: [String], colors: [Color], showLabels: Bool = false) {
        self.data = data
        self.labels = labels
        self.colors = colors
        self.showLabels = showLabels
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                ForEach(0..<data.count, id: \.self) { index in
                    PieSliceView(
                        startAngle: startAngle(for: index),
                        endAngle: endAngle(for: index),
                        color: colors[index % colors.count]
                    )
                    
                    if showLabels {
                        let midAngle = getMidAngle(for: index)
                        let radius = min(geometry.size.width, geometry.size.height) * 0.3
                        let center = CGPoint(x: geometry.size.width / 2, y: geometry.size.height / 2)
                        let labelPosition = getPosition(center: center, radius: radius, angle: midAngle)
                        
                        VStack {
                            Text(labels[index])
                                .font(.system(size: 12, weight: .bold))
                                .foregroundColor(.black)
                            Text(String(format: "%.2f", data[index]))
                                .font(.system(size: 12, weight: .bold))
                                .foregroundColor(.black)
                        }
                        .position(x: labelPosition.x, y: labelPosition.y)
                    }
                }
            }
        }
        .aspectRatio(1, contentMode: .fit)
    }
    
    private func startAngle(for index: Int) -> Double {
        let total = data.reduce(0, +)
        let upToIndex = data[..<index].reduce(0, +)
        return upToIndex / total * 360.0
    }
    
    private func endAngle(for index: Int) -> Double {
        let total = data.reduce(0, +)
        let upToIndex = data[...index].reduce(0, +)
        return upToIndex / total * 360.0
    }
    
    private func getMidAngle(for index: Int) -> Double {
        let total = data.reduce(0, +)
        let start = data[..<index].reduce(0, +)
        let midValue = start + (data[index] / 2)
        return (midValue / total * 360.0 - 90) * .pi / 180
    }
    
    private func getPosition(center: CGPoint, radius: CGFloat, angle: Double) -> CGPoint {
        let x = center.x + radius * CGFloat(Foundation.cos(angle))
        let y = center.y + radius * CGFloat(Foundation.sin(angle))
        return CGPoint(x: x, y: y)
    }
}
