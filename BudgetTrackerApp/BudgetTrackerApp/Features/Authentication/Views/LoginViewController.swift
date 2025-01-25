//
//  LoginViewController.swift
//  BudgetTrackerApp
//
//  Created by Tiko on 18.01.25.
//
import UIKit
import FirebaseAuth
import SwiftUI

class LoginViewController: UIViewController {

    private let gradientLayer = CAGradientLayer()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Sign in"
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.textAlignment = .center
        return label
    }()

    /*private*/ public let emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Email"
        textField.borderStyle = .roundedRect
        textField.layer.borderColor = UIColor(red: 0.31, green: 0.73, blue: 0.55, alpha: 1).cgColor
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 8
        textField.backgroundColor = .white
        return textField
    }()

    /*private*/ public let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Password"
        textField.borderStyle = .roundedRect
        textField.layer.borderColor = UIColor(red: 0.31, green: 0.73, blue: 0.55, alpha: 1).cgColor
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 8
        textField.backgroundColor = .white
        textField.isSecureTextEntry = true
        return textField
    }()

    private let togglePasswordButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(systemName: "eye"), for: .normal)
        button.setImage(UIImage(systemName: "eye.slash"), for: .selected)
        button.tintColor = .gray
        return button
    }()

    /*private*/ public let signInButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign in", for: .normal)
        button.backgroundColor = UIColor(red: 0.31, green: 0.73, blue: 0.55, alpha: 1)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        button.addTarget(nil, action: #selector(signInButtonTapped), for: .touchUpInside)
        return button
    }()

    private let signUpLabel: UILabel = {
        let label = UILabel()
        label.text = "Don't have an account?"
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .center
        return label
    }()

    private let signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign Up", for: .normal)
        button.setTitleColor(UIColor(red: 0.31, green: 0.73, blue: 0.55, alpha: 1), for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.addTarget(nil, action: #selector(signUpButtonTapped), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupGradientBackground()
        setupUI()
        configurePasswordToggle()
    }

    private func setupGradientBackground() {
        gradientLayer.colors = [
            UIColor(red: 0.81, green: 0.896, blue: 0.853, alpha: 1).cgColor,
            UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        ]
        gradientLayer.locations = [0, 1]
        gradientLayer.startPoint = CGPoint(x: 0.25, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 0.75, y: 0.5)
        gradientLayer.frame = view.bounds
        view.layer.insertSublayer(gradientLayer, at: 0)
    }

    private func setupUI() {
        view.addSubview(titleLabel)
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(togglePasswordButton)
        view.addSubview(signInButton)
        view.addSubview(signUpLabel)
        view.addSubview(signUpButton)

        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        togglePasswordButton.translatesAutoresizingMaskIntoConstraints = false
        signInButton.translatesAutoresizingMaskIntoConstraints = false
        signUpLabel.translatesAutoresizingMaskIntoConstraints = false
        signUpButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 60),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            emailTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 40),
            emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            emailTextField.heightAnchor.constraint(equalToConstant: 44),

            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 20),
            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            passwordTextField.heightAnchor.constraint(equalToConstant: 44),

            togglePasswordButton.centerYAnchor.constraint(equalTo: passwordTextField.centerYAnchor),
            togglePasswordButton.trailingAnchor.constraint(equalTo: passwordTextField.trailingAnchor, constant: -10),

            signInButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 40),
            signInButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            signInButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            signInButton.heightAnchor.constraint(equalToConstant: 50),

            signUpLabel.topAnchor.constraint(equalTo: signInButton.bottomAnchor, constant: 30),
            signUpLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            signUpButton.topAnchor.constraint(equalTo: signUpLabel.bottomAnchor, constant: 5),
            signUpButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }

    private func configurePasswordToggle() {
        togglePasswordButton.addTarget(self, action: #selector(togglePasswordVisibility), for: .touchUpInside)
    }

    @objc private func togglePasswordVisibility() {
        passwordTextField.isSecureTextEntry.toggle()
        togglePasswordButton.isSelected.toggle()
    }

    @objc private func signInButtonTapped() {
        guard let email = emailTextField.text, !email.isEmpty,
              let password = passwordTextField.text, !password.isEmpty else {
            showAlert("Email and Password are required!")
            return
        }
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error = error {
                self.showAlert("Sign In Failed: \(error.localizedDescription)")
                return
            }

            let mainTabBarController = MainTabBarController()
            mainTabBarController.modalPresentationStyle = .fullScreen
            self.present(mainTabBarController, animated: true, completion: nil)
        }
    }

    /*private*/ public func showAlert(_ message: String, completion: (() -> Void)? = nil) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
            completion?()
        })
        present(alert, animated: true, completion: nil)
    }

    @objc private func signUpButtonTapped() {
        let signUpViewController = SignUpViewController()
        navigationController?.pushViewController(signUpViewController, animated: true)
    }
}
