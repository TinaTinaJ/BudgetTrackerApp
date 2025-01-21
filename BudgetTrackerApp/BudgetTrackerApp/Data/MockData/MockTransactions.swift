//
//  MockTransactions.swift
//  BudgetTrackerApp
//
//  Created by Tiko on 19.01.25.
//

import UIKit
import Foundation

struct MockTransaction {
    let id: String
    let icon: String
    let title: String
    let amount: Double
    let date: String
    let account: String
    let iconColor: UIColor
}

struct MockExpense {
    let id: String
    let title: String
    let amount: Double
    let dueDate: String
    let category: String
    let status: String
    let percentage: Double
}

struct MockGoal {
    let id: String
    let title: String
    let icon: String
    let currentAmount: Double
    let targetAmount: Double
    let status: String
}

class MockDataProvider {
    static let shared = MockDataProvider()
    
    let transactions: [MockTransaction] = [
        MockTransaction(id: "20", icon: "music.note", title: "Concert Tickets", amount: 150, date: "5 May 2025", account: "Cash", iconColor: .systemPink),
        MockTransaction(id: "19", icon: "pawprint.fill", title: "Pet Supplies", amount: 100, date: "30 April 2024", account: "Debit Card", iconColor: .brown),
        MockTransaction(id: "18", icon: "briefcase.fill", title: "Work Lunch", amount: 25, date: "25 April 2024", account: "Cash", iconColor: .darkGray),
        MockTransaction(id: "17", icon: "tv.fill", title: "Streaming Subscription", amount: 12, date: "20 April 2024", account: "Cash", iconColor: .purple),
        MockTransaction(id: "16", icon: "airplane", title: "Flight Tickets", amount: 500, date: "15 April 2024", account: "Credit Card", iconColor: .blue),
        MockTransaction(id: "15", icon: "leaf.fill", title: "Gardening Supplies", amount: 50, date: "10 April 2024", account: "Debit Card", iconColor: .green),
        MockTransaction(id: "14", icon: "stethoscope", title: "Doctor Visit", amount: 200, date: "5 April 2024", account: "Insurance", iconColor: .red),
        MockTransaction(id: "13", icon: "bus.fill", title: "Bus Ticket", amount: 15, date: "30 March 2024", account: "Cash", iconColor: .cyan),
        MockTransaction(id: "12", icon: "tshirt.fill", title: "Clothing", amount: 100, date: "25 March 2024", account: "Cash", iconColor: .systemTeal),
        MockTransaction(id: "11", icon: "camera.fill", title: "Camera", amount: 1200, date: "20 March 2024", account: "Credit Card", iconColor: .orange),
        MockTransaction(id: "10", icon: "cup.and.saucer.fill", title: "Coffee", amount: 5, date: "15 March 2024", account: "Cash", iconColor: .brown),
        MockTransaction(id: "9", icon: "fuelpump.fill", title: "Gas", amount: 70, date: "10 March 2024", account: "Debit Card", iconColor: .systemIndigo),
        MockTransaction(id: "8", icon: "bed.double.fill", title: "Hotel Stay", amount: 200, date: "5 March 2024", account: "Credit Card", iconColor: .systemPink),
        MockTransaction(id: "7", icon: "building.columns.fill", title: "Museum Tickets", amount: 20, date: "1 March 2024", account: "Cash", iconColor: .systemGreen),
        MockTransaction(id: "6", icon: "book.fill", title: "Books", amount: 60, date: "25 February 2024", account: "Cash", iconColor: .systemPurple),
        MockTransaction(id: "5", icon: "gamecontroller.fill", title: "Gaming Console", amount: 300, date: "20 February 2024", account: "Credit Card", iconColor: .systemOrange),
        MockTransaction(id: "4", icon: "cart.fill", title: "Groceries", amount: 150, date: "15 February 2024", account: "Debit Card", iconColor: .systemBlue),
        MockTransaction(id: "3", icon: "car.fill", title: "Car", amount: 500, date: "12 February 2024", account: "Cash", iconColor: .systemYellow),
        MockTransaction(id: "2", icon: "gift.fill", title: "Grandma's present", amount: 40, date: "12 February 2024", account: "Cash", iconColor: .magenta),
        MockTransaction(id: "1", icon: "house.fill", title: "Apartment", amount: 4000, date: "12 February 2024", account: "Cash", iconColor: .systemBlue)
    ]
    
    let expenses: [MockExpense] = [
        MockExpense(id: "8", title: "Entertainment", amount: 150, dueDate: "10 March 2025", category: "Fun", status: "Unpaid", percentage: 10),
        MockExpense(id: "7", title: "Transportation", amount: 300, dueDate: "5 March 2024", category: "Transport", status: "Paid", percentage: 25),
        MockExpense(id: "6", title: "Groceries", amount: 400, dueDate: "1 March 2024", category: "Food", status: "Paid", percentage: 20),
        MockExpense(id: "5", title: "Subscriptions", amount: 50, dueDate: "28 February 2024", category: "Subscriptions", status: "Unpaid", percentage: 39),
        MockExpense(id: "4", title: "Bills", amount: 550, dueDate: "25 February 2024", category: "Bills", status: "Unpaid", percentage: 2),
        MockExpense(id: "3", title: "Total loans", amount: 10000, dueDate: "20 February 2024", category: "Loans", status: "Unpaid", percentage: 40),
        MockExpense(id: "2", title: "Education", amount: 500, dueDate: "15 February 2024", category: "Education", status: "Unpaid", percentage: 39),
        MockExpense(id: "1", title: "Health", amount: 1000, dueDate: "12 February 2024", category: "Health", status: "Paid", percentage: 33)
    ]
    
    let goals: [MockGoal] = [
        MockGoal(id: "5", title: "Wedding Fund", icon: "heart.fill", currentAmount: 2000, targetAmount: 15000, status: "Paid"),
        MockGoal(id: "4", title: "Home Renovation", icon: "house.fill", currentAmount: 3000, targetAmount: 10000, status: "Unpaid"),
        MockGoal(id: "3", title: "New Laptop", icon: "laptop", currentAmount: 700, targetAmount: 1500, status: "Paid"),
        MockGoal(id: "2", title: "Car", icon: "car", currentAmount: 1000, targetAmount: 5000, status: "Unpaid"),
        MockGoal(id: "1", title: "Vacation", icon: "airplane", currentAmount: 500, targetAmount: 2000, status: "Paid")
    ]
}
