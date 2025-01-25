//
//  BankAccount.swift
//  BudgetTrackerApp
//
//  Created by Tiko on 18.01.25.
//
import Foundation

struct BankAccount: Codable, Identifiable {
    let id: String
    let name: String
    let type: AccountType
    let bankName: String?
    let accountNumber: String
    let balance: Double
    let currency: String
    
    enum AccountType: String, Codable {
        case bank
        case cash
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case type
        case bankName
        case accountNumber
        case balance
        case currency
    }
}
