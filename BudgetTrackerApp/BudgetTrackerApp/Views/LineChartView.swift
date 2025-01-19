//
//  LineChartView.swift
//  BudgetTrackerApp
//
//  Created by Tiko on 19.01.25.
//

import SwiftUI

struct LineChartView: View {
    let data: [LineData]
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
                    let x = CGFloat(data.firstIndex(where: { $0.date == point.date }) ?? 0) * geometry.size.width / CGFloat(data.count - 1)
                    let y = geometry.size.height - CGFloat(point.value)
                    path.addLine(to: CGPoint(x: x, y: y))
                }
            }
            .stroke(color, lineWidth: 2)
        }
        .padding()
    }
}

struct LineData {
    let date: String
    let value: Double
}
