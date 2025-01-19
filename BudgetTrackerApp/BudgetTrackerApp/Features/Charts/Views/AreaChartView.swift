//
//  AreaChartView.swift
//  BudgetTrackerApp
//
//  Created by Tiko on 19.01.25.
//

import SwiftUI

struct AreaChartView: View {
    let data: [AreaData]
    let color: Color

    var body: some View {
        GeometryReader { geometry in
            Path { path in
                guard let firstPoint = data.first else { return }
                let startPoint = CGPoint(
                    x: 0,
                    y: geometry.size.height - CGFloat(firstPoint.value)
                )
                path.move(to: startPoint)

                for point in data.dropFirst() {
                    let x = CGFloat(data.firstIndex(where: { $0.period == point.period }) ?? 0) * geometry.size.width / CGFloat(data.count - 1)
                    let y = geometry.size.height - CGFloat(point.value)
                    path.addLine(to: CGPoint(x: x, y: y))
                }
                path.addLine(to: CGPoint(x: geometry.size.width, y: geometry.size.height))
                path.addLine(to: CGPoint(x: 0, y: geometry.size.height))
                path.closeSubpath()
            }
            .fill(color.opacity(0.3))
        }
        .padding()
    }
}

struct AreaData {
    let period: String
    let value: Double
}

