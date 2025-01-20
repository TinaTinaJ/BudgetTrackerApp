//
//  BarChartView.swift
//  BudgetTrackerApp
//
//  Created by Tiko on 19.01.25.
//

import SwiftUI

struct BarChartView: View {
    let data: [BarData]
    let colors: [Color]
    
    var body: some View {
        GeometryReader { geometry in
            HStack(alignment: .bottom, spacing: 16) {
                ForEach(data) { item in
                    VStack(spacing: 8) {
                        Text(String(format: "%.0f", item.value))
                            .font(.system(size: 12))
                            .foregroundColor(.gray)
                        
                        RoundedRectangle(cornerRadius: 4)
                            .fill(getBarColor(for: item.label))
                            .frame(width: 40, height: getBarHeight(value: item.value, maxHeight: geometry.size.height * 0.7))
                        
                        Text(item.label)
                            .font(.system(size: 12))
                            .foregroundColor(.gray)
                            .fixedSize()
                    }
                }
            }
            .frame(maxWidth: .infinity)
            .frame(height: geometry.size.height)
            .padding(.horizontal)
        }
    }
    
    private func getBarHeight(value: Double, maxHeight: CGFloat) -> CGFloat {
        let maxValue = data.map { $0.value }.max() ?? 1
        return CGFloat(value) / CGFloat(maxValue) * maxHeight
    }
    
    private func getBarColor(for label: String) -> Color {
        switch label {
        case "TBC", "BOG", "VTB":
            return .lightBlue
        case "Liberty":
            return .lightOrange
        case "Credo":
            return .brandGreen
        default:
            return colors.first ?? .blue
        }
    }
}
