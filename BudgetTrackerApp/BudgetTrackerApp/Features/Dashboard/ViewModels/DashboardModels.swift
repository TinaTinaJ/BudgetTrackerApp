//
//  DashboardModels.swift
//  BudgetTrackerApp
//
//  Created by Tiko on 20.01.25.
//
import Foundation

struct BarData: Identifiable {
    let id = UUID()
    let label: String
    let value: Double
}

struct ComparisonData: Identifiable {
    let id = UUID()
    let date: String
    let oneYearAgo: Double
    let twoYearsAgo: Double
    let present: Double
}

struct MonthlyBalanceData: Identifiable {
    let id = UUID()
    let date: String
    let value: Double
}
