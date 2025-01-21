//
//  ExpenseCell.swift
//  BudgetTrackerApp
//
//  Created by Tiko on 21.01.25.
//
import UIKit

final class ExpenseCell: UICollectionViewCell {
    static let identifier = "ExpenseCell"
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 12
        return view
    }()
    
    private let iconContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBlue.withAlphaComponent(0.1)
        view.layer.cornerRadius = 20
        return view
    }()
    
    private let iconImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.tintColor = .systemBlue
        return iv
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .medium)
        return label
    }()
    
    private let statusLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    private let amountLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.textAlignment = .right
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        [containerView, iconContainer, iconImageView, titleLabel, statusLabel, amountLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        contentView.addSubview(containerView)
        containerView.addSubview(iconContainer)
        iconContainer.addSubview(iconImageView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(statusLabel)
        containerView.addSubview(amountLabel)
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            
            iconContainer.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            iconContainer.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            iconContainer.widthAnchor.constraint(equalToConstant: 40),
            iconContainer.heightAnchor.constraint(equalToConstant: 40),
            
            iconImageView.centerXAnchor.constraint(equalTo: iconContainer.centerXAnchor),
            iconImageView.centerYAnchor.constraint(equalTo: iconContainer.centerYAnchor),
            iconImageView.widthAnchor.constraint(equalToConstant: 20),
            iconImageView.heightAnchor.constraint(equalToConstant: 20),
            
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: iconContainer.trailingAnchor, constant: 12),
            
            statusLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            statusLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            statusLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -16),
            
            amountLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            amountLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16)
        ])
    }
    
    func configure(with expense: MockExpense) {
        titleLabel.text = expense.title
        statusLabel.text = expense.status
        statusLabel.textColor = expense.status == "Paid" ? .systemGreen : .systemRed
        amountLabel.text = String(format: "%.2f GEL", expense.amount)
        iconImageView.image = UIImage(systemName: "creditcard.fill")
    }
}
