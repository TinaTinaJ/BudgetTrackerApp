//
//  MoreMenuItem.swift
//  BudgetTrackerApp
//
//  Created by Tiko on 23.01.25.
//

import Foundation

struct MoreMenuItem: Identifiable {
    let id = UUID()
    let title: String
    let icon: String
    let action: () -> Void
}
