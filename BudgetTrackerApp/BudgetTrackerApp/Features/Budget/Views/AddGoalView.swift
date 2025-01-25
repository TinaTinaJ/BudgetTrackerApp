//
//  AddGoalView.swift
//  BudgetTrackerApp
//
//  Created by Tiko on 25.01.25.
//
import SwiftUI
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth

struct AddGoalView: View {
    @Environment(\.dismiss) private var dismiss
    @State /*private*/ public var goalTitle = ""
    @State /*private*/ public var costAmount = ""
    @State /*private*/ public var selectedCurrency = "GEL"
    @State /*private*/ public var showAlert = false
    @State private var isLoading = false
    @State /*private*/ public var errorMessage = "Please enter both a goal title and a valid cost amount."
    
    let mockData: MockDataProvider
    let currencies = ["GEL", "USD", "EUR"]
    private let db = Firestore.firestore()
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(uiColor: .backgroundMint)
                    .ignoresSafeArea()
                
                VStack(spacing: 16) {
                    TextField("Goal Title", text: $goalTitle)
                        .textFieldStyle(CustomTextFieldStyle())
                        .padding(.top, 24)
                    
                    HStack(spacing: 8) {
                        ForEach(currencies, id: \.self) { currency in
                            Button(action: {
                                selectedCurrency = currency
                            }) {
                                Text(currency)
                                    .font(.system(size: 14, weight: .medium))
                                    .foregroundColor(selectedCurrency == currency ? .white : .black)
                                    .frame(maxWidth: .infinity)
                                    .frame(height: 36)
                                    .background(
                                        RoundedRectangle(cornerRadius: 8)
                                            .fill(selectedCurrency == currency ? Color(uiColor: .brandGreen) : Color.white)
                                    )
                                    .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
                            }
                        }
                    }
                    
                    TextField("Cost Amount", text: $costAmount)
                        .textFieldStyle(CustomTextFieldStyle())
                        .keyboardType(.numberPad)
                    
                    if isLoading {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle())
                            .scaleEffect(1.5)
                            .padding()
                    }
                    
                    Spacer()
                    
                    Button(action: saveGoal) {
                        Text("Save Goal")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: 48)
                            .background(Color(uiColor: .brandGreen))
                            .cornerRadius(8)
                    }
                    .disabled(isLoading)
                    .padding(.bottom, 16)
                }
                .padding(.horizontal, 16)
            }
            .navigationTitle("Add New Goal")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
            .alert("Invalid Input", isPresented: $showAlert) {
                Button("OK", role: .cancel) { }
            } message: {
                Text(errorMessage)
            }
        }
    }
    
    /*private*/ public func saveGoal() {
        let trimmedTitle = goalTitle.trimmingCharacters(in: .whitespacesAndNewlines)
        let trimmedAmount = costAmount.trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard !trimmedTitle.isEmpty,
              !trimmedAmount.isEmpty,
              let cost = Double(trimmedAmount) else {
            errorMessage = "Please enter both a goal title and a valid cost amount."
            showAlert = true
            return
        }
        
        guard let userId = Auth.auth().currentUser?.uid else {
            errorMessage = "Please sign in to save goals."
            showAlert = true
            return
        }
        
        isLoading = true
        
        let goalId = UUID().uuidString
        let goalData: [String: Any] = [
            "id": goalId,
            "title": trimmedTitle,
            "icon": "star.fill",
            "currentAmount": 0.0,
            "targetAmount": cost,
            "status": "Unpaid",
            "currency": selectedCurrency,
            "createdAt": Timestamp(),
            "userId": userId
        ]
        
        db.collection("users")
            .document(userId)
            .collection("goals")
            .document(goalId)
            .setData(goalData) { error in
                DispatchQueue.main.async {
                    if let error = error {
                        print("Error saving goal: \(error.localizedDescription)")
                        errorMessage = "Failed to save goal. Please try again."
                        showAlert = true
                    } else {
                        let newGoal = MockGoal(
                            id: goalId,
                            title: trimmedTitle,
                            icon: "star.fill",
                            currentAmount: 0.0,
                            targetAmount: cost,
                            status: "Unpaid"
                        )
                        
                        mockData.goals.append(newGoal)
                        dismiss()
                    }
                    isLoading = false
                }
            }
    }
}

struct CustomTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding(.horizontal, 16)
            .frame(height: 48)
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.white)
                    .shadow(
                        color: Color.black.opacity(0.1),
                        radius: 4,
                        x: 0,
                        y: 2
                    )
            )
    }
}
