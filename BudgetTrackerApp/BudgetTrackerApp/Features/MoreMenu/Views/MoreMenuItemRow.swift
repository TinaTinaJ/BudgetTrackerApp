//
//  MoreMenuItemRow.swift
//  BudgetTrackerApp
//
//  Created by Tiko on 23.01.25.
//

import SwiftUI

struct MoreMenuItemRow: View {
    let icon: String
    let title: String
    var showArrow: Bool = true
    var iconColor: Color = .brandGreen
    
    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: icon)
                .foregroundColor(iconColor)
                .frame(width: 24, height: 24)
            
            Text(title)
                .foregroundColor(.primary)
            
            Spacer()
            
            if showArrow {
                Image(systemName: "chevron.right")
                    .foregroundColor(.gray)
            }
        }
        .padding(.vertical, 12)
        .padding(.horizontal, 16)
        .background(Color.white)
    }
}
