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
}

struct AccountSummary: Identifiable {
    let id: String
    let name: String
    let amount: Double
}
