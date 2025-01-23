//
//  CardItemView.swift
//  BudgetTrackerApp
//
//  Created by Tiko on 23.01.25.
//
import SwiftUI

struct CardItemView: View {
    let card: BankCard
    
    var body: some View {
        HStack(spacing: 16) {
            Image(card.cardType == .visa ? "visa_logo" : "mastercard_logo")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 40, height: 40)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(card.bankName)
                    .font(.headline)
                
                Text(card.cardNumber)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            
            Spacer()
            
            HStack(spacing: 4) {
                Text("\(Int(card.amount))")
                    .font(.headline)
                Text(card.currency.symbol)
                    .font(.headline)
            }
        }
        .padding(16)
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.05), radius: 2, x: 0, y: 2)
    }
}
