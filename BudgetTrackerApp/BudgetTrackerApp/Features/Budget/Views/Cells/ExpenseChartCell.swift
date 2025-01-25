//
//  ExpenseChartCell.swift
//  BudgetTrackerApp
//
//  Created by Tiko on 21.01.25.
//

import UIKit

final class ExpenseChartCell: UICollectionViewCell {
    static let identifier = "ExpenseChartCell"
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 12
        view.clipsToBounds = true
        return view
    }()
    
    private let pieChartView: BudgetPieChartView = {
        let view = BudgetPieChartView()
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Spending structure"
        label.font = .systemFont(ofSize: 16, weight: .medium)
        return label
    }()
    
    private let legendStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 12
        stack.distribution = .equalSpacing
        stack.alignment = .leading
        return stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        contentView.addSubview(containerView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(pieChartView)
        containerView.addSubview(legendStackView)
        
        [containerView, titleLabel, pieChartView, legendStackView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            
            pieChartView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            pieChartView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            pieChartView.widthAnchor.constraint(equalToConstant: 150),
            pieChartView.heightAnchor.constraint(equalToConstant: 150),
            
            legendStackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            legendStackView.leadingAnchor.constraint(equalTo: pieChartView.trailingAnchor, constant: 16),
            legendStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            legendStackView.bottomAnchor.constraint(lessThanOrEqualTo: containerView.bottomAnchor, constant: -16)
        ])
    }
    
    private func createLegendItem(text: String, color: UIColor) -> UIView {
        let container = UIView()
        
        let colorView = UIView()
        colorView.backgroundColor = color
        colorView.layer.cornerRadius = 4
        
        let label = UILabel()
        label.text = text
        label.font = .systemFont(ofSize: 12)
        label.numberOfLines = 0
        
        [colorView, label].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            container.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            colorView.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            colorView.centerYAnchor.constraint(equalTo: container.centerYAnchor),
            colorView.widthAnchor.constraint(equalToConstant: 8),
            colorView.heightAnchor.constraint(equalToConstant: 8),
            
            label.leadingAnchor.constraint(equalTo: colorView.trailingAnchor, constant: 8),
            label.topAnchor.constraint(equalTo: container.topAnchor),
            label.bottomAnchor.constraint(equalTo: container.bottomAnchor),
            label.trailingAnchor.constraint(equalTo: container.trailingAnchor)
        ])
        
        return container
    }
    
    func configure(with expenses: [MockExpense]) {
        legendStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        pieChartView.configure(with: expenses)
        
        expenses.forEach { expense in
            let legendItem = createLegendItem(
                text: "\(expense.category): \(expense.percentage)%",
                color: expense.status == "Paid" ? .systemGreen : .systemRed
            )
            legendStackView.addArrangedSubview(legendItem)
        }
    }
}
