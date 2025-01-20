//
//  MockDashboardData.swift
//  BudgetTrackerApp
//
//  Created by Tiko on 19.01.25.
//
import Foundation

class MockDashboardData {
    static let shared = MockDashboardData()
    
    func convertTotalBalance(to currency: String) -> Double {
        switch currency {
        case "USD":
            return 851.00 * 0.37
        case "EUR":
            return 851.00 * 0.33
        default:
            return 851.00
        }
    }
    
    let pieChartData: [String: [Double]] = [
        "GEL": [423.55, 427.45],
        "USD": [157.72, 159.16],
        "EUR": [140.77, 142.56]
    ]
    
    let accountSummaries: [String: [AccountSummary]] = [
        "GEL": [
            AccountSummary(id: "1", name: "Savings", amount: 423.55),
            AccountSummary(id: "2", name: "Expenses", amount: 427.45),
            AccountSummary(id: "3", name: "Cash", amount: 0.00)
        ],
        "USD": [
            AccountSummary(id: "1", name: "Savings", amount: 157.72),
            AccountSummary(id: "2", name: "Expenses", amount: 159.16),
            AccountSummary(id: "3", name: "Cash", amount: 0.00)
        ],
        "EUR": [
            AccountSummary(id: "1", name: "Savings", amount: 140.77),
            AccountSummary(id: "2", name: "Expenses", amount: 142.56),
            AccountSummary(id: "3", name: "Cash", amount: 0.00)
        ]
    ]
    
    static let balanceData: [BarData] = [
        BarData(label: "TBC", value: 40),
        BarData(label: "BOG", value: 88),
        BarData(label: "Liberty", value: 60),
        BarData(label: "Credo", value: 35),
        BarData(label: "VTB", value: 70)
    ]
    
    static let earningsData: [Double] = [577.45, 423.55]
    static let earningsLabels = ["TBC", "BOG"]
    
    static let spendingData: [Double] = [577.45, 423.55]
    static let spendingLabels = ["Rent", "Food"]
    
    static let comparisonData: [ComparisonData] = [
        ComparisonData(date: "10 May", oneYearAgo: 2000, twoYearsAgo: 4000, present: 6000),
        ComparisonData(date: "20 May", oneYearAgo: 3500, twoYearsAgo: 4500, present: 5500),
        ComparisonData(date: "30 May", oneYearAgo: 1500, twoYearsAgo: 5000, present: 4000),
        ComparisonData(date: "Today", oneYearAgo: 2500, twoYearsAgo: 4500, present: 5000)
    ]
}

struct AccountSummary: Identifiable {
    let id: String
    let name: String
    let amount: Double
}
