//
//  AddTransactionViewController.swift
//  BudgetTrackerApp
//
//  Created by Tiko on 18.01.25.
//
import UIKit
import FirebaseFirestore
import FirebaseAuth

class AddTransactionViewController: UIViewController {
    
    // MARK: - UI Components
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
    
    private let amountLabel: UILabel = {
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
        layout.minimumLineSpacing = 20
        layout.minimumInteritemSpacing = 20
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        cv.delegate = self
        cv.dataSource = self
        cv.register(CategoryCell.self, forCellWithReuseIdentifier: "CategoryCell")
        cv.allowsSelection = true
        cv.isUserInteractionEnabled = true
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()
    
    private let confirmButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Confirm", for: .normal)
        button.backgroundColor = .brandGreen
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        button.layer.cornerRadius = 12
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var numPad: CustomNumberPad = {
        let pad = CustomNumberPad()
        pad.delegate = self
        pad.translatesAutoresizingMaskIntoConstraints = false
        return pad
    }()
    
    // MARK: - Properties
    private let currencies = ["GEL", "USD", "EUR"]
    private var selectedCurrency = "GEL"
    private var selectedCategory: String?
    private let db = Firestore.firestore()
    
    private let categories: [(image: String, name: String)] = [
        ("🚗", "Car"), ("🍽️", "Food"), ("🏠", "Home"), ("🎁", "Gift"),
        ("⚕️", "Health"), ("👕", "Clothes"), ("🚌", "Transport"), ("📦", "Other")
    ]
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
    }
    
    // MARK: - Setup
    private func setupUI() {
        view.backgroundColor = .backgroundMint
        title = "Add Transaction"
        
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
            currencyStackView.addArrangedSubview(button)
        }
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
            
            collectionView.topAnchor.constraint(equalTo: categoryLabel.bottomAnchor, constant: 10),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            collectionView.heightAnchor.constraint(equalToConstant: 180),
            
            confirmButton.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 10),
            confirmButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            confirmButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            confirmButton.heightAnchor.constraint(equalToConstant: 44),
            
            numPad.topAnchor.constraint(equalTo: confirmButton.bottomAnchor, constant: 10),
            numPad.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            numPad.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            numPad.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            numPad.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    // MARK: - Actions
    @objc private func currencyTapped(_ sender: UIButton) {
        guard let currency = sender.title(for: .normal) else { return }
        
        currencyStackView.arrangedSubviews.forEach { view in
            if let button = view as? UIButton {
                let isSelected = button == sender
                button.backgroundColor = isSelected ? .brandGreen : .white
                button.setTitleColor(isSelected ? .white : .black, for: .normal)
            }
        }
        
        selectedCurrency = currency
        currencyLabel.text = currency
    }
    
    @objc private func confirmTapped() {
        guard let amountText = amountLabel.text,
              let amount = Double(amountText),
              let category = selectedCategory else {
            showAlert(message: "Please select amount and category")
            return
        }
        
        saveTransaction(amount: amount, category: category)
    }
    
    private func saveTransaction(amount: Double, category: String) {
        guard let userId = Auth.auth().currentUser?.uid else {
            showAlert(message: "Please sign in to add transactions")
            return
        }
        
        let isIncome = segmentedControl.selectedSegmentIndex == 0
        let transaction: [String: Any] = [
            "amount": amount,
            "currency": selectedCurrency,
            "category": category,
            "type": isIncome ? "income" : "expense",
            "date": Timestamp(),
            "createdAt": Timestamp()
        ]
        
        db.collection("users").document(userId)
            .collection("transactions")
            .addDocument(data: transaction) { [weak self] error in
                if let error = error {
                    self?.showAlert(message: "Error: \(error.localizedDescription)")
                } else {
                    self?.showAlert(message: "Transaction saved successfully") { _ in
                        self?.resetForm()
                    }
                }
            }
    }
    
    private func resetForm() {
        amountLabel.text = "0"
        selectedCategory = nil
        collectionView.reloadData()
    }
    
    private func showAlert(message: String, completion: ((UIAlertAction) -> Void)? = nil) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: completion))
        present(alert, animated: true)
    }
}

// MARK: - UICollectionView Extensions
extension AddTransactionViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCell", for: indexPath) as! CategoryCell
        let category = categories[indexPath.item]
        cell.configure(with: category.image, name: category.name)
        cell.isSelected = category.name == selectedCategory
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.bounds.width - 60) / 4
        return CGSize(width: width, height: 70)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedCategory = categories[indexPath.item].name
        collectionView.reloadData()
    }
}

// MARK: - CustomNumberPadDelegate
extension AddTransactionViewController: CustomNumberPadDelegate {
    func numberPadDidEnterValue(_ value: String) {
        amountLabel.text = value
    }
    
    func numberPadDidClear() {
        amountLabel.text = "0"
    }
}
