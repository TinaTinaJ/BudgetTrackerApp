//
//  CategoryCell.swift
//  BudgetTrackerApp
//
//  Created by Tiko on 19.01.25.
//
import UIKit

class CategoryCell: UICollectionViewCell {
    
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
    
    override var isSelected: Bool {
        didSet {
            animate()
        }
    }
    
    private var icon: String?
    private var name: String?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.isUserInteractionEnabled = true
        isUserInteractionEnabled = true
        backgroundColor = .clear
        
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
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(cellTapped))
        addGestureRecognizer(tapGesture)
    }
    
    @objc private func cellTapped() {

        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
        
        UIView.animate(withDuration: 0.1, animations: {
            self.containerView.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        }) { _ in
            UIView.animate(withDuration: 0.1) {
                self.containerView.transform = .identity
            }
        }
    }
    
    private func animate() {
        UIView.animate(withDuration: 0.2) {
            self.containerView.backgroundColor = self.isSelected ? UIColor(red: 54/255, green: 179/255, blue: 126/255, alpha: 1) : .white
            self.iconLabel.textColor = self.isSelected ? .white : .black
            self.nameLabel.textColor = self.isSelected ? UIColor(red: 54/255, green: 179/255, blue: 126/255, alpha: 1) : .black
            self.containerView.transform = self.isSelected ? CGAffineTransform(scaleX: 1.05, y: 1.05) : .identity
        }
    }
    
    func configure(with icon: String, name: String) {
        self.icon = icon
        self.name = name
        iconLabel.text = icon
        nameLabel.text = name
        
        animate()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        iconLabel.text = nil
        nameLabel.text = nil
        isSelected = false
        containerView.transform = .identity
    }
}
