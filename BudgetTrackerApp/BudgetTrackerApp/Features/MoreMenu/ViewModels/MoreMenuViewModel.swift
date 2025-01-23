//
//  MoreMenuViewModel.swift
//  BudgetTrackerApp
//
//  Created by Tiko on 23.01.25.
//

import SwiftUI
import Firebase
import FirebaseAuth


class MoreMenuViewModel: ObservableObject {
    @Published var userEmail: String = ""
    @Published var isDarkMode: Bool = false
    @Published var currentLanguage: String = "English"
    @Published var shouldNavigateToLogin: Bool = false
    
    init() {
        fetchUserData()
    }
    
    private func fetchUserData() {
        if let user = FirebaseAuth.Auth.auth().currentUser {
            userEmail = user.email ?? ""
        }
    }
    
    func toggleLanguage() {
        currentLanguage = currentLanguage == "English" ? "ქართული" : "English"
    }
    
    func signOut() {
        do {
            try FirebaseAuth.Auth.auth().signOut()
            shouldNavigateToLogin = true
        } catch {
            print("Error signing out: \(error.localizedDescription)")
        }
    }
}
