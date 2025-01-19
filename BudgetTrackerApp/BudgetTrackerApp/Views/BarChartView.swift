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
        HStack(alignment: .bottom, spacing: 8) {
            ForEach(data.indices, id: \.self) { index in
                let barData = data[index]
                VStack {
                    Text(String(format: "%.0f", barData.value))
                        .font(.caption)
                        .foregroundColor(.gray)

                    Rectangle()
                        .fill(colors[index % colors.count])
                        .frame(width: 20, height: CGFloat(barData.value))

                    Text(barData.label)
                        .font(.caption)
                        .foregroundColor(.gray)
                }
            }
        }
        .padding()
    }
}

struct BarData {
    let label: String
    let value: Double
}

struct BarChartView_Previews: PreviewProvider {
    static var previews: some View {
        BarChartView(
            data: [
                BarData(label: "Jan", value: 40),
                BarData(label: "Feb", value: 70),
                BarData(label: "Mar", value: 50),
                BarData(label: "Apr", value: 30),
                BarData(label: "May", value: 80)
            ],
            colors: [.brandGreen, .lightBlue, .lightOrange, .peachBackground]
        )
        .frame(height: 200)
    }
}


