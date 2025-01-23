//
//  CardsAccountsView.swift
//  BudgetTrackerApp
//
//  Created by Tiko on 23.01.25.
//
import SwiftUI

struct CardsAccountsView: View {
    @StateObject private var viewModel = CardsAccountsViewModel()
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.black)
                }
                
                Text("Cards & Accounts")
                    .font(.headline)
                
                Spacer()
            }
            .padding()
            .background(Color.backgroundMint)
            
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Total Balance")
                            .font(.title2)
                            .foregroundColor(.gray)
                            .padding(.horizontal)
                        
                        Text(viewModel.totalBalance)
                            .font(.title3)
                            .fontWeight(.semibold)
                            .padding(.horizontal)
                        
                        ForEach(viewModel.cards) { card in
                            CardItemView(card: card)
                                .swipeActions(edge: .trailing) {
                                    Button(role: .destructive) {
                                        withAnimation {
                                            viewModel.removeCard(id: card.id)
                                        }
                                    } label: {
                                        Image(systemName: "trash")
                                    }
                                }
                        }
                        .padding(.horizontal)
                        
                        Button(action: {
                        }) {
                            HStack {
                                Spacer()
                                Image(systemName: "plus.circle.fill")
                                    .foregroundColor(.brandGreen)
                                    .font(.system(size: 24))
                                Spacer()
                            }
                            .frame(height: 60)
                            .background(Color.white)
                            .cornerRadius(12)
                        }
                        .padding(.horizontal)
                    }
                }
                .padding(.vertical)
            }
        }
        .navigationBarHidden(true)
        .background(Color.customLightGray.edgesIgnoringSafeArea(.all))
    }
}
