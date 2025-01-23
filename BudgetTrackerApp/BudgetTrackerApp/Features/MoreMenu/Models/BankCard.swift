//
//  BankCard.swift
//  BudgetTrackerApp
//
//  Created by Tiko on 23.01.25.
//

import SwiftUI

struct BankCard: Identifiable {
    let id: String
    let bankName: String
    let cardNumber: String
    let amount: Double
    let cardType: CardType
    let currency: CurrencyType
    
    enum CardType {
        case visa
        case mastercard
    }
    
    enum CurrencyType {
        case gel
        case euro
        
        var symbol: String {
            switch self {
            case .gel: return "₾"
            case .euro: return "€"
            }
        }
    }
}
