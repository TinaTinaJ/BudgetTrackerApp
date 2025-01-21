//
//  ExpenseToBePaidCell.swift
//  BudgetTrackerApp
//
//  Created by Tiko on 22.01.25.
//

import UIKit

final class ExpenseToBePaidCell: UICollectionViewCell {
    static let identifier = "ExpenseToBePaidCell"
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 12
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.layer.shadowOpacity = 0.1
        view.layer.shadowRadius = 4
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "To be paid"
        label.font = .systemFont(ofSize: 18, weight: .medium)
        return label
    }()
    
    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 12
        return stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        [containerView, titleLabel, stackView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        contentView.addSubview(containerView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(stackView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            
            stackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            stackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            stackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -16)
        ])
    }
    
    private func createExpenseRow(title: String, amount: Double) -> UIView {
        let container = UIView()
        
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = .systemFont(ofSize: 14)
        
        let amountLabel = UILabel()
        amountLabel.text = String(format: "%.2f GEL", amount)
        amountLabel.font = .systemFont(ofSize: 14)
        amountLabel.textAlignment = .right
        
        let chevronImageView = UIImageView(image: UIImage(systemName: "chevron.down"))
        chevronImageView.tintColor = .gray
        chevronImageView.contentMode = .scaleAspectFit
        
        [titleLabel, amountLabel, chevronImageView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            container.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: container.centerYAnchor),
            
            chevronImageView.centerYAnchor.constraint(equalTo: container.centerYAnchor),
            chevronImageView.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 8),
            chevronImageView.widthAnchor.constraint(equalToConstant: 12),
            chevronImageView.heightAnchor.constraint(equalToConstant: 12),
            
            amountLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            amountLabel.centerYAnchor.constraint(equalTo: container.centerYAnchor),
            
            container.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        return container
    }
    
    func configure(with expenses: [MockExpense]) {
        stackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        let unpaidExpenses = expenses.filter { $0.status == "Unpaid" }
        
        let categories = ["Total loans", "Health", "Education", "Bills", "Subscriptions"]
        
        categories.forEach { category in
            if let expense = unpaidExpenses.first(where: { $0.category == category }) {
                let row = createExpenseRow(title: expense.title, amount: expense.amount)
                stackView.addArrangedSubview(row)
            }
        }
    }
}
