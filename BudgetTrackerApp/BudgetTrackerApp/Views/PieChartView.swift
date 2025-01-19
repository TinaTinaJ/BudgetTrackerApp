//
//  PieChartView.swift
//  BudgetTrackerApp
//
//  Created by Tiko on 18.01.25.
//
import SwiftUI

struct PieChartView: View {
    var data: [Double]
    var labels: [String]

    var body: some View {
        VStack {
            ZStack {
                ForEach(0..<data.count, id: \.self) { index in
                    PieSliceView(
                        startAngle: self.startAngle(for: index),
                        endAngle: self.endAngle(for: index)
                    )
                    .fill(self.color(for: index))
                }
            }
            .frame(width: 150, height: 150)

            // Labels
            VStack(alignment: .leading, spacing: 8) {
                ForEach(0..<labels.count, id: \.self) { index in
                    Text("\(labels[index]): \(String(format: "%.2f", data[index]))")
                        .font(.caption)
                        .foregroundColor(index == 0 ? .green : .blue)
                }
            }
        }
    }

    private func startAngle(for index: Int) -> Angle {
        let total = data.reduce(0, +)
        let sum = data.prefix(index).reduce(0, +)
        return .degrees((sum / total) * 360.0)
    }

    private func endAngle(for index: Int) -> Angle {
        let total = data.reduce(0, +)
        let sum = data.prefix(index + 1).reduce(0, +)
        return .degrees((sum / total) * 360.0)
    }

    private func color(for index: Int) -> Color {
        let colors: [Color] = [.blue, .green, .orange, .red, .purple]
        return colors[index % colors.count]
    }
}

struct PieSliceView: Shape {
    var startAngle: Angle
    var endAngle: Angle

    func path(in rect: CGRect) -> Path {
        var path = Path()
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let radius = min(rect.width, rect.height) / 2
        path.move(to: center)
        path.addArc(
            center: center,
            radius: radius,
            startAngle: startAngle,
            endAngle: endAngle,
            clockwise: false
        )
        return path
    }
}

struct PieChartView_Previews: PreviewProvider {
    static var previews: some View {
        PieChartView(
            data: [423.55, 577.45],
            labels: ["ING Account", "BRD Account"]
        )
        .frame(width: 200, height: 200)
    }
}
