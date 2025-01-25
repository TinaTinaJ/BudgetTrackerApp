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
    @State private var progress: CGFloat = 0
    
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
                    endAngle: Angle(degrees: startAngle - 90 + (endAngle - startAngle) * progress),
                    clockwise: false
                )
                path.closeSubpath()
            }
            .fill(color)
        }
        .onAppear {
            withAnimation(.easeOut(duration: 1.0)) {
                progress = 1
            }
        }
        .onChange(of: endAngle) { _ in
            progress = 0
            withAnimation(.easeOut(duration: 1.0)) {
                progress = 1
            }
        }
    }
}

struct PieChartView: View {
    let data: [Double]
    let labels: [String]
    let colors: [Color]
    let showLabels: Bool
    @State private var isAnimating: Bool = false
    
    init(data: [Double], labels: [String], colors: [Color], showLabels: Bool = false) {
        self.data = data
        self.labels = labels
        self.colors = colors
        self.showLabels = showLabels
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Circle()
                    .fill(Color.white)
                    .frame(width: min(geometry.size.width, geometry.size.height),
                           height: min(geometry.size.width, geometry.size.height))
                    .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
                
                ForEach(0..<data.count, id: \.self) { index in
                    PieSliceView(
                        startAngle: startAngle(for: index),
                        endAngle: endAngle(for: index),
                        color: colors[index % colors.count]
                    )
                    
                    if showLabels {
                        let midAngle = getMidAngle(for: index)
                        let radius = min(geometry.size.width, geometry.size.height) * 0.25
                        let center = CGPoint(x: geometry.size.width / 2, y: geometry.size.height / 2)
                        let labelPosition = getPosition(center: center, radius: radius, angle: midAngle)
                        
                        VStack(spacing: 2) {
                            Text(labels[index])
                                .font(.system(size: 11))
                                .foregroundColor(.black)
                                .opacity(isAnimating ? 1 : 0)
                            Text(String(format: "%.2f", data[index]))
                                .font(.system(size: 11))
                                .foregroundColor(.black)
                                .opacity(isAnimating ? 1 : 0)
                        }
                        .position(x: labelPosition.x, y: labelPosition.y)
                    }
                }
            }
        }
        .aspectRatio(1, contentMode: .fit)
        .onAppear {
            withAnimation(.easeIn(duration: 1.0).delay(0.5)) {
                isAnimating = true
            }
        }
        .onChange(of: data) { _ in
            isAnimating = false
            withAnimation(.easeIn(duration: 1.0).delay(0.5)) {
                isAnimating = true
            }
        }
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
