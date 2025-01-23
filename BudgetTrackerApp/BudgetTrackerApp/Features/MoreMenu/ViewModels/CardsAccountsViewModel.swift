//
//  CardsAccountsViewModel.swift
//  BudgetTrackerApp
//
//  Created by Tiko on 23.01.25.
//
import SwiftUI

class CardsAccountsViewModel: ObservableObject {
    @Published var cards: [BankCard] = [
        BankCard(id: "1", bankName: "TBC", cardNumber: "****4345", amount: 560, cardType: .mastercard, currency: .gel),
        BankCard(id: "2", bankName: "BOG", cardNumber: "****4789", amount: 760, cardType: .visa, currency: .euro)
    ]
    
    private let euroToGelRate: Double = 2.85
    
    var totalBalance: String {
        let gelAmount = cards.filter { $0.currency == .gel }.reduce(0) { $0 + $1.amount }
        let euroAmount = cards.filter { $0.currency == .euro }.reduce(0) { $0 + $1.amount }
        let totalInGel = gelAmount + (euroAmount * euroToGelRate)
        return "\(Int(totalInGel)) ₾"
    }
    
    func removeCard(id: String) {
        cards.removeAll { $0.id == id }
    }
}
