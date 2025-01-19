//
//  MockTransactions.swift
//  BudgetTrackerApp
//
//  Created by Tiko on 19.01.25.
//

// MockTransactions.swift

import Foundation

struct MockTransaction {
    let id: String
    let icon: String
    let title: String
    let amount: Double
    let date: String
    let account: String
}

struct MockExpense {
    let id: String
    let title: String
    let amount: Double
    let dueDate: String
    let category: String
    let status: String
}

struct MockGoal {
    let id: String
    let title: String
    let icon: String
    let currentAmount: Double
    let targetAmount: Double
    let status: String
}

var mockTransactions: [MockTransaction] = [ 
    MockTransaction(id: "1", icon: "house", title: "Apartment", amount: 4000, date: "12 February 2022", account: "Cash"),
    MockTransaction(id: "2", icon: "gift", title: "Grandma’s present", amount: 40, date: "12 February 2022", account: "Cash"),
    MockTransaction(id: "3", icon: "car", title: "Car", amount: 500, date: "12 February 2022", account: "Cash")
]

let mockExpenses: [MockExpense] = [
    MockExpense(id: "1", title: "Health", amount: 1000, dueDate: "12 February 2022", category: "Health", status: "Paid"),
    MockExpense(id: "2", title: "Education", amount: 500, dueDate: "15 February 2022", category: "Education", status: "Unpaid")
]

let mockGoals: [MockGoal] = [
    MockGoal(id: "1", title: "Vacation", icon: "airplane", currentAmount: 500, targetAmount: 2000, status: "In Progress"),
    MockGoal(id: "2", title: "Car", icon: "car", currentAmount: 1000, targetAmount: 5000, status: "In Progress")
]

