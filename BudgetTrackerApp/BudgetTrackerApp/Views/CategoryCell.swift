//
//  CategoryCell.swift
//  BudgetTrackerApp
//
//  Created by Tiko on 19.01.25.
//
import UIKit

class CategoryCell: UICollectionViewCell {
    
    // MARK: - UI Components
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 25
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.layer.shadowRadius = 4
        view.layer.shadowOpacity = 0.1
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let iconLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Properties
    override var isSelected: Bool {
        didSet {
            updateSelectionState()
        }
    }
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    private func setupUI() {
        contentView.isUserInteractionEnabled = true
        isUserInteractionEnabled = true
        
        contentView.addSubview(containerView)
        containerView.addSubview(iconLabel)
        contentView.addSubview(nameLabel)
        
        NSLayoutConstraint.activate([
            containerView.widthAnchor.constraint(equalToConstant: 50),
            containerView.heightAnchor.constraint(equalToConstant: 50),
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            containerView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            iconLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            iconLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            
            nameLabel.topAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 8),
            nameLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }
    
    private func updateSelectionState() {
        UIView.animate(withDuration: 0.2) {
            self.containerView.backgroundColor = self.isSelected ? .brandGreen : .white
            self.iconLabel.textColor = self.isSelected ? .white : .black
            self.nameLabel.textColor = self.isSelected ? .brandGreen : .black
            self.containerView.transform = self.isSelected ? CGAffineTransform(scaleX: 1.05, y: 1.05) : .identity
        }
    }
    
    // MARK: - Configuration
    func configure(with icon: String, name: String) {
        iconLabel.text = icon
        nameLabel.text = name
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        iconLabel.text = nil
        nameLabel.text = nil
        isSelected = false
    }
}
