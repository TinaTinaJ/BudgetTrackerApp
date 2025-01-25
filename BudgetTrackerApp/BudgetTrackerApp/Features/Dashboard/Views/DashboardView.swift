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
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    HStack {
                        Spacer()
                        Picker("Currency", selection: $selectedCurrency) {
                            Text("GEL").tag("GEL")
                            Text("USD").tag("USD")
                            Text("EUR").tag("EUR")
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        .frame(width: 200)
                        .onChange(of: selectedCurrency) { newValue in
                            totalBalance = MockDashboardData.shared.convertTotalBalance(to: newValue)
                        }
                        Spacer()
                    }
                    
                    totalBalanceCard
                    
                    balanceCard
                    
                    monthlyStatsRow
                    
                    comparisonCard
                }
                .padding()
            }
            .background(Color.backgroundMint.ignoresSafeArea())
            .navigationTitle("Dashboard")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    private var totalBalanceCard: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Spacer()
                Text("\(totalBalance, specifier: "%.2f") \(selectedCurrency)")
                    .font(.system(size: 32, weight: .bold))
                Spacer()
            }
            
            Text("Total balance")
                .foregroundColor(.gray)
                .frame(maxWidth: .infinity, alignment: .center)
            
            HStack(spacing: 24) {
                PieChartView(
                    data: MockDashboardData.shared.pieChartData[selectedCurrency] ?? [0, 0],
                    labels: ["Savings", "Expenses"],
                    colors: [.brandGreen, .lightBlue],
                    showLabels: true
                )
                .frame(width: 120, height: 120)
                
                VStack(alignment: .leading, spacing: 12) {
                    ForEach(MockDashboardData.shared.accountSummaries[selectedCurrency] ?? [], id: \.id) { account in
                        HStack {
                            Text(account.name)
                                .foregroundColor(.gray)
                            Spacer()
                            Text("\(account.amount, specifier: "%.2f")")
                            Text(selectedCurrency)
                                .foregroundColor(.gray)
                        }
                    }
                }
            }
        }
        .padding(20)
        .background(Color.white)
        .cornerRadius(16)
    }
    
    private var balanceCard: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Balance")
                .font(.headline)
            BarChartView(
                data: MockDashboardData.balanceData,
                colors: [.lightBlue, .brandGreen, .lightOrange, .brandGreen, .lightBlue]
            )
            .frame(height: 200)
        }
        .padding(20)
        .background(Color.white)
        .cornerRadius(16)
    }
    
    private var monthlyStatsRow: some View {
        HStack(spacing: 16) {
            monthlyStatCard(
                title: "Earnings\nthis month",
                data: MockDashboardData.earningsData,
                labels: MockDashboardData.earningsLabels,
                colors: [.lightBlue, .brandGreen]
            )
            
            monthlyStatCard(
                title: "Spent\nthis month",
                data: MockDashboardData.spendingData,
                labels: MockDashboardData.spendingLabels,
                colors: [.lightBlue, .brandGreen]
            )
        }
    }
    
    private func monthlyStatCard(title: String, data: [Double], labels: [String], colors: [Color]) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(title)
                .font(.headline)
                .lineLimit(2)
                .fixedSize(horizontal: false, vertical: true)
            
            PieChartView(
                data: data,
                labels: labels,
                colors: colors,
                showLabels: true
            )
            .frame(height: 120)
        }
        .frame(maxWidth: .infinity)
        .padding(16)
        .background(Color.white)
        .cornerRadius(16)
    }
    
    private var comparisonCard: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Comparing between periods")
                .font(.headline)
            
            MultiLineChartView(data: MockDashboardData.comparisonData)
                .frame(height: 200)
            
            HStack(spacing: 16) {
                legendItem(color: .orange, text: "One year ago")
                legendItem(color: .lightBlue, text: "Two years ago")
                legendItem(color: .brandGreen, text: "Present")
            }
        }
        .padding(20)
        .background(Color.white)
        .cornerRadius(16)
    }
    
    private func legendItem(color: Color, text: String) -> some View {
        HStack(spacing: 8) {
            Circle()
                .fill(color)
                .frame(width: 8, height: 8)
            Text(text)
                .font(.caption)
                .foregroundColor(.gray)
        }
    }
}
