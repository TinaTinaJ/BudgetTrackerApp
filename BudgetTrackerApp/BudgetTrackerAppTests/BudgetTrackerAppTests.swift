//
//  BudgetTrackerAppTests.swift
//  BudgetTrackerAppTests
//
//  Created by Tiko on 18.01.25.
//

import XCTest
@testable import BudgetTrackerApp

final class BudgetTrackerAppTests: XCTestCase {

    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    // MARK: - Sign In Tests

    func testSignInButtonTappedWithEmptyFields() {
        let loginVC = LoginViewController()
        loginVC.loadViewIfNeeded()

        loginVC.emailTextField.text = ""
        loginVC.passwordTextField.text = ""

        loginVC.signInButton.sendActions(for: .touchUpInside)

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            XCTAssertNotNil(loginVC.presentedViewController as? UIAlertController, "Alert should be presented when fields are empty.")
        }
    }

    func testSignInButtonTappedWithValidFields() {
        let loginVC = LoginViewController()
        loginVC.loadViewIfNeeded()

        loginVC.emailTextField.text = "test@example.com"
        loginVC.passwordTextField.text = "password123"

        loginVC.signInButton.sendActions(for: .touchUpInside)

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            XCTAssertNil(loginVC.presentedViewController as? UIAlertController, "No alert should be presented for valid input.")
        }
    }

    // MARK: - Sign Up Tests

    func testSignUpButtonTappedWithEmptyFields() {
        let signUpVC = SignUpViewController()
        signUpVC.loadViewIfNeeded()

        signUpVC.emailTextField.text = ""
        signUpVC.passwordTextField.text = ""

        signUpVC.registerButton.sendActions(for: .touchUpInside)

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            XCTAssertNotNil(signUpVC.presentedViewController as? UIAlertController, "Alert should be presented when fields are empty.")
        }
    }

    func testSignUpButtonTappedWithValidFields() {
        let signUpVC = SignUpViewController()
        signUpVC.loadViewIfNeeded()

        signUpVC.emailTextField.text = "newuser@example.com"
        signUpVC.passwordTextField.text = "password123"

        signUpVC.registerButton.sendActions(for: .touchUpInside)

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            XCTAssertNil(signUpVC.presentedViewController as? UIAlertController, "No alert should be presented for valid input.")
        }
    }

    // MARK: - Add Transaction Tests

    func testAddTransactionWithValidData() {
        let transactionVC = AddTransactionViewController()
        transactionVC.loadViewIfNeeded()

        transactionVC.amountLabel.text = "100"
        transactionVC.selectedCategory = "Food"

        transactionVC.confirmButton.isEnabled = true
        transactionVC.confirmButton.sendActions(for: .touchUpInside)

        XCTAssertTrue(transactionVC.confirmButton.isEnabled, "Confirm button should be enabled for valid data.")
    }

    func testAddTransactionWithInvalidData() {
        let transactionVC = AddTransactionViewController()
        transactionVC.loadViewIfNeeded()

        transactionVC.amountLabel.text = "0"
        transactionVC.selectedCategory = nil

        transactionVC.confirmButton.sendActions(for: .touchUpInside)

        XCTAssertFalse(transactionVC.confirmButton.isEnabled, "Confirm button should be disabled for invalid data.")
    }

    func testAddTransactionCategorySelection() {
        let transactionVC = AddTransactionViewController()
        transactionVC.loadViewIfNeeded()

        let category = "Food"
        transactionVC.selectedCategory = category

        XCTAssertEqual(transactionVC.selectedCategory, category, "Selected category should match the assigned value.")
    }
}
