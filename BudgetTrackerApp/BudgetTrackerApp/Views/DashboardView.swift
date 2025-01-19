//
//  DashboardView.swift
//  BudgetTrackerApp
//
//  Created by Tiko on 18.01.25.
//

import SwiftUI

struct DashboardView: View {
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 20) {
                // Total Balance Section
                VStack(alignment: .center, spacing: 10) {
                    Text("60,28")
                        .font(.system(size: 50, weight: .bold))
                        .foregroundColor(.black)

                    Text("Total Balance")
                        .font(.headline)
                        .foregroundColor(.gray)
                }
                .frame(maxWidth: .infinity)

                // Pie Charts Section
                HStack(spacing: 16) {
                    PieChartView(data: [423.55, 577.45], labels: ["ING Account", "BRD Account"])
                        .frame(width: 120, height: 120)

                    PieChartView(data: [0.0], labels: ["Cash"])
                        .frame(width: 120, height: 120)
                }
                .frame(maxWidth: .infinity)

                // Placeholder Section for other charts
                Text("Other summaries and charts will go here.")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .padding(.top, 20)

                Spacer()
            }
            .padding()
            .background(Color(red: 0.976, green: 0.983, blue: 0.973).ignoresSafeArea())
            .navigationTitle("Dashboard")
        }
    }
}

//struct PieChartView: View {
//    let data: [Double]
//    let labels: [String]
//
//    var body: some View {
//        VStack {
//            // Placeholder for PieChart (Customize with your library)
//            Circle()
//                .fill(Color.blue)
//                .frame(width: 100, height: 100)
//
//            ForEach(0..<labels.count, id: \.self) { index in
//                Text("\(labels[index]): \(String(format: "%.2f", data[index]))")
//                    .font(.caption)
//                    .foregroundColor(index == 0 ? .green : .blue)
//            }
//        }
//    }
//}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
    }
}
