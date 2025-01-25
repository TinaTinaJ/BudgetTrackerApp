//
//  Budget.swift
//  BudgetTrackerApp
//
//  Created by Tiko on 18.01.25.
//
//import Foundation
//
//struct Budget: Codable, Identifiable {
//    let id: String
//    let categoryId: String
//    let amount: Double
//    let period: BudgetPeriod
//    let startDate: Date
//    let endDate: Date
//    
//    enum BudgetPeriod: String, Codable {
//        case monthly
//        case yearly
//    }
//    
//    enum CodingKeys: String, CodingKey {
//        case id
//        case categoryId
//        case amount
//        case period
//        case startDate
//        case endDate
//    }
//    
//    init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        id = try container.decode(String.self, forKey: .id)
//        categoryId = try container.decode(String.self, forKey: .categoryId)
//        amount = try container.decode(Double.self, forKey: .amount)
//        period = try container.decode(BudgetPeriod.self, forKey: .period)
//        startDate = try container.decode(Date.self, forKey: .startDate)
//        endDate = try container.decode(Date.self, forKey: .endDate)
//    }
//}
