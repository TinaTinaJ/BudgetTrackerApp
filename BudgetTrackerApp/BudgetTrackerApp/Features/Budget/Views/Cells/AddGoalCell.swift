//
//  AddGoalCell.swift
//  BudgetTrackerApp
//
//  Created by Tiko on 22.01.25.
//

import UIKit

final class AddGoalCell: UICollectionViewCell {
    static let identifier = "AddGoalCell"
    
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
    
    private let plusIcon: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(systemName: "plus")
        iv.tintColor = .gray
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    private let addLabel: UILabel = {
        let label = UILabel()
        label.text = "Add new"
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textColor = .gray
        return label
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
        [containerView, plusIcon, addLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        contentView.addSubview(containerView)
        containerView.addSubview(plusIcon)
        containerView.addSubview(addLabel)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            plusIcon.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            plusIcon.centerYAnchor.constraint(equalTo: containerView.centerYAnchor, constant: -10),
            plusIcon.widthAnchor.constraint(equalToConstant: 30),
            plusIcon.heightAnchor.constraint(equalToConstant: 30),
            
            addLabel.topAnchor.constraint(equalTo: plusIcon.bottomAnchor, constant: 8),
            addLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor)
        ])
    }
}
