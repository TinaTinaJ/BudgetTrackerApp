//
//  DashboardView.swift
//  BudgetTrackerApp
//
//  Created by Tiko on 18.01.25.
//

import SwiftUI

struct DashboardView: View {
    @State private var selectedCurrency: String = "GEL"
    @State private var totalBalance: Double = 851.00
    
    private let pieChartData: [Double] = [60, 40]
    private let accountSummaries: [String] = ["Salary", "Savings"]
    private let accountAmounts: [Double] = [500.0, 351.0]
    private let barChartDataEarnings: [BarData] = [
        BarData(label: "Jan", value: 500),
        BarData(label: "Feb", value: 600),
        BarData(label: "Mar", value: 700)
    ]
    private let barChartDataSpendings: [BarData] = [
        BarData(label: "Rent", value: 300),
        BarData(label: "Food", value: 250),
        BarData(label: "Transport", value: 150)
    ]
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    VStack {
                        HStack {
                            Spacer()
                            Picker("Currency", selection: $selectedCurrency) {
                                Text("GEL").tag("GEL")
                                Text("USD").tag("USD")
                                Text("EUR").tag("EUR")
                            }
                            .pickerStyle(SegmentedPickerStyle())
                            .padding()
                            .onChange(of: selectedCurrency) { _ in
                                if selectedCurrency == "USD" {
                                    totalBalance = 320.00
                                } else if selectedCurrency == "EUR" {
                                    totalBalance = 280.00
                                } else {
                                    totalBalance = 851.00
                                }
                            }
                            Spacer()
                        }

                        Text("\(String(format: "%.2f", totalBalance)) \(selectedCurrency)")
                            .font(.system(size: 40, weight: .bold))
                            .foregroundColor(.black)

                        Text("Total Balance")
                            .font(.headline)
                            .foregroundColor(.customLightGray)
                    }
                    .padding()
                    .background(Color.backgroundMint)
                    .cornerRadius(10)

                    HStack(alignment: .center) {
                        PieChartView(
                            data: pieChartData,
                            labels: ["Income", "Expenses"],
                            colors: [.brandGreen, .lightOrange]
                        )
                        .frame(width: 150, height: 150)

                        VStack(alignment: .leading, spacing: 10) {
                            ForEach(0..<accountSummaries.count, id: \.self) { index in
                                HStack {
                                    Text(accountSummaries[index])
                                        .foregroundColor(.brandGreen)
                                    Spacer()
                                    Text("\(String(format: "%.2f", accountAmounts[index])) \(selectedCurrency)")
                                        .foregroundColor(.black)
                                }
                            }
                        }
                    }

                    Divider()
                        .padding(.vertical)

                    VStack(alignment: .leading, spacing: 20) {
                        Text("Earnings this month")
                            .font(.headline)
                            .foregroundColor(.black)

                        BarChartView(
                            data: normalizeBarData(barChartDataEarnings),
                            colors: [.lightBlue, .darkBlue]
                        )
                        .frame(height: 200)

                        Text("Spent this month")
                            .font(.headline)
                            .foregroundColor(.black)

                        BarChartView(
                            data: normalizeBarData(barChartDataSpendings),
                            colors: [.lightOrange, .peachBackground]
                        )
                        .frame(height: 200)
                    }
                }
                .padding()
            }
            .background(Color.backgroundMint.ignoresSafeArea())
            .navigationTitle("Dashboard")
        }
    }
    
    private func normalizeBarData(_ data: [BarData]) -> [BarData] {
        guard let maxValue = data.map({ $0.value }).max() else { return data }
        return data.map { BarData(label: $0.label, value: ($0.value / maxValue) * 150) }
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
    }
}

