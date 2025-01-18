//
//  SignUpViewController.swift
//  BudgetTrackerApp
//
//  Created by Tiko on 18.01.25.
//

import UIKit
import FirebaseAuth

class SignUpViewController: UIViewController {

    private let gradientLayer = CAGradientLayer()

    // UI Elements
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Sign up"
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.textAlignment = .center
        return label
    }()

    private let firstNameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "First Name"
        textField.borderStyle = .roundedRect
        textField.layer.borderColor = UIColor(red: 0.31, green: 0.73, blue: 0.55, alpha: 1).cgColor
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 8
        textField.backgroundColor = .white
        return textField
    }()

    private let lastNameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Last Name"
        textField.borderStyle = .roundedRect
        textField.layer.borderColor = UIColor(red: 0.31, green: 0.73, blue: 0.55, alpha: 1).cgColor
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 8
        textField.backgroundColor = .white
        return textField
    }()

    private let emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Email"
        textField.borderStyle = .roundedRect
        textField.layer.borderColor = UIColor(red: 0.31, green: 0.73, blue: 0.55, alpha: 1).cgColor
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 8
        textField.backgroundColor = .white
        return textField
    }()

    private let passwordTextField: UITextField = {
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

    private let registerButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Register", for: .normal)
        button.backgroundColor = UIColor(red: 0.31, green: 0.73, blue: 0.55, alpha: 1)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)
        return button
    }()

    private let signInLabel: UILabel = {
        let label = UILabel()
        label.text = "Already a member?"
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .center
        return label
    }()

    private let signInButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign in", for: .normal)
        button.setTitleColor(UIColor(red: 0.31, green: 0.73, blue: 0.55, alpha: 1), for: .normal)
        button.addTarget(self, action: #selector(signInButtonTapped), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupGradientBackground()
        setupUI()
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
        view.addSubview(firstNameTextField)
        view.addSubview(lastNameTextField)
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(registerButton)
        view.addSubview(signInLabel)
        view.addSubview(signInButton)

        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        firstNameTextField.translatesAutoresizingMaskIntoConstraints = false
        lastNameTextField.translatesAutoresizingMaskIntoConstraints = false
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        registerButton.translatesAutoresizingMaskIntoConstraints = false
        signInLabel.translatesAutoresizingMaskIntoConstraints = false
        signInButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            firstNameTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            firstNameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            firstNameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            firstNameTextField.heightAnchor.constraint(equalToConstant: 44),

            lastNameTextField.topAnchor.constraint(equalTo: firstNameTextField.bottomAnchor, constant: 12),
            lastNameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            lastNameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            lastNameTextField.heightAnchor.constraint(equalToConstant: 44),

            emailTextField.topAnchor.constraint(equalTo: lastNameTextField.bottomAnchor, constant: 12),
            emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            emailTextField.heightAnchor.constraint(equalToConstant: 44),

            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 12),
            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            passwordTextField.heightAnchor.constraint(equalToConstant: 44),

            registerButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 20),
            registerButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            registerButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            registerButton.heightAnchor.constraint(equalToConstant: 50),

            signInLabel.topAnchor.constraint(equalTo: registerButton.bottomAnchor, constant: 20),
            signInLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            signInButton.topAnchor.constraint(equalTo: signInLabel.bottomAnchor, constant: 5),
            signInButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }

    @objc private func registerButtonTapped() {
        guard let email = emailTextField.text, !email.isEmpty,
              let password = passwordTextField.text, !password.isEmpty else {
            showAlert("All fields are required!")
            return
        }

        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                self.showAlert("Registration Failed: \(error.localizedDescription)")
                return
            }
            self.showAlert("Registration Successful!") {
                self.navigationController?.popViewController(animated: true)
            }
        }
    }

    private func showAlert(_ message: String, completion: (() -> Void)? = nil) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
            completion?()
        })
        present(alert, animated: true, completion: nil)
    }

    @objc private func signInButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
}


