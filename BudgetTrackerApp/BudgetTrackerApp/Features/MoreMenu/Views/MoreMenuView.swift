//
//  MoreMenuView.swift
//  BudgetTrackerApp
//
//  Created by Tiko on 23.01.25.
//

import SwiftUI

struct MoreMenuView: View {
    @StateObject private var viewModel = MoreMenuViewModel()
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.customLightGray.edgesIgnoringSafeArea(.all)
                
                VStack(spacing: 0) {
                    VStack(spacing: 8) {
                        Image(systemName: "person.circle.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 80, height: 80)
                            .foregroundColor(.brandGreen)
                            .background(Color.white)
                            .clipShape(Circle())
                        
                        Text(viewModel.userEmail)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    .padding(24)
                    .frame(maxWidth: .infinity)
                    .background(Color.backgroundMint)
                    
                    ScrollView {
                        VStack(spacing: 1) {
                            VStack(spacing: 1) {
                                NavigationLink(destination: CardsAccountsView()) {
                                    MoreMenuItemRow(icon: "creditcard", title: "Cards & Accounts")
                                        .foregroundColor(.primary)
                                }
                                
                                MoreMenuItemRow(icon: "person", title: "Change Username", showArrow: false)
                                MoreMenuItemRow(icon: "lock", title: "Change Password", showArrow: false)
                            }
                            .background(Color.white)
                            
                            VStack(spacing: 1) {
                                HStack(spacing: 16) {
                                    Image(systemName: "globe")
                                        .foregroundColor(.brandGreen)
                                        .frame(width: 24, height: 24)
                                    
                                    Text("Language")
                                    
                                    Spacer()
                                    
                                    Button(action: {
                                        viewModel.toggleLanguage()
                                    }) {
                                        Text(viewModel.currentLanguage)
                                            .foregroundColor(.blue)
                                        Image(systemName: "chevron.right")
                                            .foregroundColor(.gray)
                                    }
                                }
                                .padding(.vertical, 12)
                                .padding(.horizontal, 16)
                                .background(Color.white)
                                
                                HStack(spacing: 16) {
                                    Image(systemName: "moon.fill")
                                        .foregroundColor(.brandGreen)
                                        .frame(width: 24, height: 24)
                                    
                                    Text("Dark Mode")
                                    
                                    Spacer()
                                    
                                    Toggle("", isOn: $viewModel.isDarkMode)
                                        .labelsHidden()
                                }
                                .padding(.vertical, 12)
                                .padding(.horizontal, 16)
                                .background(Color.white)
                            }
                            
                            Spacer()
                            
                            VStack {
                                Spacer()
                                Button(action: {
                                    viewModel.signOut()
                                }) {
                                    MoreMenuItemRow(
                                        icon: "arrow.right.square",
                                        title: "Logout",
                                        iconColor: .red
                                    )
                                }
                            }
                            .padding(.top, 32)
                        }
                    }
                }
            }
            .navigationBarTitle("More", displayMode: .inline)
        }
        .onChange(of: viewModel.shouldNavigateToLogin) { oldValue, newValue in
            if newValue {
                if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                   let window = windowScene.windows.first {
                    window.rootViewController = LoginViewController()
                    window.makeKeyAndVisible()
                }
            }
        }
    }
}
