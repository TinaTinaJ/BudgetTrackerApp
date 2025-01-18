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
            ScrollView {
                VStack(spacing: 16) {
                    Text("60,28")
                        .font(.system(size: 36, weight: .bold))
                        .padding()
                    
                    Text("Total Balance")
                        .font(.headline)
                        .foregroundColor(.gray)

                    HStack(spacing: 16) {
                        PieChartView(data: [423.55, 577.45], labels: ["ING Account", "BRD Account"])
                            .frame(width: 120, height: 120)
                        PieChartView(data: [0.0], labels: ["Cash"])
                            .frame(width: 120, height: 120)
                    }

                    Text("Other summaries and charts will go here.")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .padding()
                }
                .padding()
            }
            .navigationTitle("Dashboard")
        }
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
    }
}
