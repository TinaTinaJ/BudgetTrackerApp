//
//  AddTransactionViewController.swift
//  BudgetTrackerApp
//
//  Created by Tiko on 18.01.25.
//
import UIKit
import Foundation
import FirebaseFirestore
import FirebaseAuth
import FirebaseCore

class AddTransactionViewController: UIViewController {
    private let segmentedControl: UISegmentedControl = {
        let control = UISegmentedControl(items: ["New income", "New expense"])
        control.selectedSegmentIndex = 0
        control.backgroundColor = .clear
        control.selectedSegmentTintColor = .brandGreen
        let normalAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.black,
            .font: UIFont.systemFont(ofSize: 16)
        ]
        let selectedAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.white,
            .font: UIFont.systemFont(ofSize: 16)
        ]
        control.setTitleTextAttributes(normalAttributes, for: .normal)
        control.setTitleTextAttributes(selectedAttributes, for: .selected)
        control.translatesAutoresizingMaskIntoConstraints = false
        return control
    }()

    internal let amountLabel: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 40, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let currencyLabel: UILabel = {
        let label = UILabel()
        label.text = "GEL"
        label.textColor = .systemBlue
        label.font = .systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let currencyStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 10
        stack.distribution = .fillEqually
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    private let categoryLabel: UILabel = {
        let label = UILabel()
        label.text = "From category"
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.itemSize = CGSize(width: (UIScreen.main.bounds.width - 100) / 4, height: 60)
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        cv.delegate = self
        cv.dataSource = self
        cv.register(TransactionCategoryCell.self, forCellWithReuseIdentifier: "CategoryCell")
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.showsHorizontalScrollIndicator = false
        return cv
    }()

    internal let confirmButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Confirm", for: .normal)
        button.backgroundColor = .brandGreen
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        button.layer.cornerRadius = 12
        button.alpha = 0.5
        button.isEnabled = false
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private lazy var numPad: CustomNumberPad = {
        let pad = CustomNumberPad()
        pad.delegate = self
        pad.translatesAutoresizingMaskIntoConstraints = false
        return pad
    }()

    private let currencies = ["GEL", "USD", "EUR"]
    private var selectedCurrency = "GEL" {
        didSet {
            updateCurrencyButtons()
        }
    }
    internal var selectedCategory: String?
    private let db = Firestore.firestore()

    private var currencyButtons: [UIButton] = []

    private let categories: [(image: String, name: String)] = [
        ("🚗", "Car"), ("🍽️", "Food"), ("🏠", "Home"), ("🎁", "Gift"),
        ("⚕️", "Health"), ("👕", "Clothes"), ("🚌", "Transport"), ("📦", "Other")
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
        updateConfirmButtonState()
    }

    private func setupUI() {
        view.backgroundColor = .backgroundMint
        title = "Transactions"

        view.addSubview(segmentedControl)
        view.addSubview(amountLabel)
        view.addSubview(currencyLabel)
        view.addSubview(currencyStackView)
        view.addSubview(categoryLabel)
        view.addSubview(collectionView)
        view.addSubview(confirmButton)
        view.addSubview(numPad)

        setupCurrencyButtons()
        confirmButton.addTarget(self, action: #selector(confirmTapped), for: .touchUpInside)
    }

    private func setupCurrencyButtons() {
        currencies.forEach { currency in
            let button = UIButton(type: .system)
            button.setTitle(currency, for: .normal)
            button.backgroundColor = currency == selectedCurrency ? .brandGreen : .white
            button.setTitleColor(currency == selectedCurrency ? .white : .black, for: .normal)
            button.layer.cornerRadius = 12
            button.addTarget(self, action: #selector(currencyTapped(_:)), for: .touchUpInside)
            currencyButtons.append(button)
            currencyStackView.addArrangedSubview(button)
        }
    }

    private func updateCurrencyButtons() {
        currencyButtons.forEach { button in
            guard let currency = button.title(for: .normal) else { return }
            button.backgroundColor = currency == selectedCurrency ? .brandGreen : .white
            button.setTitleColor(currency == selectedCurrency ? .white : .black, for: .normal)
        }
        currencyLabel.text = selectedCurrency
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            segmentedControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            segmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            segmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            segmentedControl.heightAnchor.constraint(equalToConstant: 44),
            
            amountLabel.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 40),
            amountLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            currencyLabel.leadingAnchor.constraint(equalTo: amountLabel.trailingAnchor, constant: 8),
            currencyLabel.centerYAnchor.constraint(equalTo: amountLabel.centerYAnchor),
            
            currencyStackView.topAnchor.constraint(equalTo: amountLabel.bottomAnchor, constant: 30),
            currencyStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            currencyStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            currencyStackView.heightAnchor.constraint(equalToConstant: 44),
            
            categoryLabel.topAnchor.constraint(equalTo: currencyStackView.bottomAnchor, constant: 30),
            categoryLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            categoryLabel.heightAnchor.constraint(equalToConstant: 20),
            
            collectionView.topAnchor.constraint(equalTo: categoryLabel.bottomAnchor, constant: 10),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            collectionView.heightAnchor.constraint(equalToConstant: 140),
            
            confirmButton.bottomAnchor.constraint(equalTo: numPad.topAnchor, constant: -10),
            confirmButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            confirmButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            confirmButton.heightAnchor.constraint(equalToConstant: 44),
            
            numPad.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            numPad.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            numPad.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            numPad.heightAnchor.constraint(equalToConstant: 240)
        ])
    }

    @objc private func currencyTapped(_ sender: UIButton) {
        guard let currency = sender.title(for: .normal) else { return }
        selectedCurrency = currency
    }

    @objc private func confirmTapped() {
        guard let category = selectedCategory, let amountText = amountLabel.text, let amount = Double(amountText), amount > 0 else {
            showAlert(title: "Invalid Data", message: "Ensure an amount and category are selected.")
            return
        }

        let transaction = [
            "amount": amount,
            "currency": selectedCurrency,
            "category": category,
            "type": segmentedControl.selectedSegmentIndex == 0 ? "income" : "expense",
            "date": Timestamp()
        ] as [String: Any]

        guard let userId = Auth.auth().currentUser?.uid else {
            showAlert(title: "Error", message: "User not authenticated.")
            return
        }

        db.collection("users").document(userId).collection("transactions").addDocument(data: transaction) { [weak self] error in
            if let error = error {
                self?.showAlert(title: "Error", message: error.localizedDescription)
            } else {
                self?.showAlert(title: "Success", message: "Transaction saved successfully!")
                self?.resetForm()
            }
        }
    }

    private func resetForm() {
        amountLabel.text = "0"
        selectedCategory = nil
        collectionView.reloadData()
        numPad.reset()
        updateConfirmButtonState()
    }

    private func updateConfirmButtonState() {
        let amountIsValid = amountLabel.text != "0" && amountLabel.text != "0.0"
        let categoryIsSelected = selectedCategory != nil
        confirmButton.isEnabled = amountIsValid && categoryIsSelected
        confirmButton.alpha = confirmButton.isEnabled ? 1.0 : 0.5
    }

    internal func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}

extension AddTransactionViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCell", for: indexPath) as! TransactionCategoryCell
        let category = categories[indexPath.item]
        cell.configure(with: category.image, name: category.name)
        cell.isSelected = (category.name == selectedCategory)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedCategory = categories[indexPath.item].name
        collectionView.reloadData()
        updateConfirmButtonState()
    }
}

extension AddTransactionViewController: CustomNumberPadDelegate {
    func numberPadDidEnterValue(_ value: String) {
        amountLabel.text = value
        updateConfirmButtonState()
    }

    func numberPadDidClear() {
        amountLabel.text = "0"
        updateConfirmButtonState()
    }
    
    func numberPadReset() {
        }
}
