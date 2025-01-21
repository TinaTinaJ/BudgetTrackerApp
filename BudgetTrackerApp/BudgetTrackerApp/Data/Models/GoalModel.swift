//
//  GoalModel.swift
//  BudgetTrackerApp
//
//  Created by Tiko on 21.01.25.
//

import Foundation

struct Goal: Codable {
    let id: String
    let title: String
    let currentAmount: Double
    let targetAmount: Double
    let isPaid: Bool
    let icon: String
}
