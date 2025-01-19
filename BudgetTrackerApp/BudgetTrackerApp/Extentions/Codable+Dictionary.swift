//
//  Codable+Dictionary.swift
//  BudgetTrackerApp
//
//  Created by Tiko on 18.01.25.
//
import Foundation

extension Encodable {
    func asDictionary() throws -> [String: Any] {
        let encoder = JSONEncoder()
        let data = try encoder.encode(self)
        
        if let dictionary = try JSONSerialization.jsonObject(with: data) as? [String: Any] {
            return dictionary
        }
        throw NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Could not convert to dictionary"])
    }
}
