//
//  FirebaseManager.swift
//  BudgetTrackerApp
//
//  Created by Tiko on 18.01.25.
//
import Firebase
import FirebaseFirestore
import Foundation

class FirebaseManager {
    static let shared = FirebaseManager()
    let db = Firestore.firestore()
    
    private init() {}
    
    func createUserProfile(userId: String, name: String, email: String, completion: @escaping (Error?) -> Void) {
        let userRef = db.collection("users").document(userId)
        
        let userData: [String: Any] = [
            "name": name,
            "email": email,
            "preferredCurrency": "EUR",
            "createdAt": Timestamp()
        ]
        
        userRef.setData(userData) { error in
            completion(error)
        }
    }
    
    func addBankAccount(userId: String, account: BankAccount, completion: @escaping (Error?) -> Void) {
        let accountRef = db.collection("users").document(userId).collection("accounts").document()
        
        do {
            let data = try account.asDictionary()
            accountRef.setData(data) { error in
                completion(error)
            }
        } catch {
            completion(error)
        }
    }
}
