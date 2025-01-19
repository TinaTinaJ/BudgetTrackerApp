//
//  Transaction.swift
//  BudgetTrackerApp
//
//  Created by Tiko on 18.01.25.
//
import Foundation

struct Transaction: Codable, Identifiable {
    let id: String
    let amount: Double
    let type: TransactionType
    let category: String
    let description: String?
    let date: Date
    let accountId: String
    let isRecurring: Bool
    let recurringPeriod: RecurringPeriod?
    
    enum TransactionType: String, Codable {
        case income
        case expense
    }
    
    enum RecurringPeriod: String, Codable {
        case daily
        case weekly
        case monthly
        case yearly
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case amount
        case type
        case category
        case description
        case date
        case accountId
        case isRecurring
        case recurringPeriod
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        amount = try container.decode(Double.self, forKey: .amount)
        type = try container.decode(TransactionType.self, forKey: .type)
        category = try container.decode(String.self, forKey: .category)
        description = try container.decodeIfPresent(String.self, forKey: .description)
        date = try container.decode(Date.self, forKey: .date)
        accountId = try container.decode(String.self, forKey: .accountId)
        isRecurring = try container.decode(Bool.self, forKey: .isRecurring)
        recurringPeriod = try container.decodeIfPresent(RecurringPeriod.self, forKey: .recurringPeriod)
    }
}
