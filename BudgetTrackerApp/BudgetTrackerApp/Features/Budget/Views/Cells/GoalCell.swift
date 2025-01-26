//
//  GoalCell.swift
//  BudgetTrackerApp
//
//  Created by Tiko on 21.01.25.
//
import UIKit

protocol GoalCellDelegate: AnyObject {
    func didLongPressGoal(_ goal: MockGoal)
}

final class GoalCell: UICollectionViewCell {
    static let identifier = "GoalCell"
    
    weak var delegate: GoalCellDelegate?
    private var currentGoal: MockGoal?
    
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
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.textColor = .black
        return label
    }()
    
    private let costLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .gray
        return label
    }()
    
    private let leftAmountLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .gray
        return label
    }()
    
    private let statusContainer: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 8
        return view
    }()
    
    private let statusLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    private let statusIcon: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    private let progressView: UIProgressView = {
        let progress = UIProgressView(progressViewStyle: .default)
        progress.trackTintColor = .systemGray5
        return progress
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
        setupLongPressGesture()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLongPressGesture() {
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress))
        longPressGesture.minimumPressDuration = 0.5
        containerView.addGestureRecognizer(longPressGesture)
        containerView.isUserInteractionEnabled = true
    }
    
    @objc private func handleLongPress(_ gesture: UILongPressGestureRecognizer) {
        if gesture.state == .began, let goal = currentGoal {
            delegate?.didLongPressGoal(goal)
            
            let generator = UIImpactFeedbackGenerator(style: .medium)
            generator.impactOccurred()
        }
    }
    
    private func setupViews() {
        [containerView, titleLabel, costLabel, leftAmountLabel,
         statusContainer, statusLabel, statusIcon, progressView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        contentView.addSubview(containerView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(costLabel)
        containerView.addSubview(leftAmountLabel)
        containerView.addSubview(statusContainer)
        statusContainer.addSubview(statusLabel)
        statusContainer.addSubview(statusIcon)
        containerView.addSubview(progressView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            
            costLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            costLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            costLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            
            leftAmountLabel.topAnchor.constraint(equalTo: costLabel.bottomAnchor, constant: 4),
            leftAmountLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            leftAmountLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            
            statusContainer.topAnchor.constraint(equalTo: leftAmountLabel.bottomAnchor, constant: 8),
            statusContainer.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            statusContainer.heightAnchor.constraint(equalToConstant: 32),
            statusContainer.widthAnchor.constraint(equalToConstant: 100),
            
            statusLabel.leadingAnchor.constraint(equalTo: statusContainer.leadingAnchor, constant: 8),
            statusLabel.centerYAnchor.constraint(equalTo: statusContainer.centerYAnchor),
            
            statusIcon.leadingAnchor.constraint(equalTo: statusLabel.trailingAnchor, constant: 4),
            statusIcon.centerYAnchor.constraint(equalTo: statusContainer.centerYAnchor),
            statusIcon.widthAnchor.constraint(equalToConstant: 16),
            statusIcon.heightAnchor.constraint(equalToConstant: 16),
            statusIcon.trailingAnchor.constraint(equalTo: statusContainer.trailingAnchor, constant: -8),
            
            progressView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            progressView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            progressView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -16),
            progressView.heightAnchor.constraint(equalToConstant: 4)
        ])
    }
    
    func configure(with goal: MockGoal) {
        currentGoal = goal
        titleLabel.text = goal.title
        
        let formattedTargetAmount = String(format: "%.0f", goal.targetAmount)
        
        if goal.status == "Paid" {
            costLabel.text = "Cost: \(formattedTargetAmount) \(goal.currency)"
            leftAmountLabel.isHidden = true
            
            statusLabel.text = "Payed"
            statusLabel.textColor = .brandGreen
            statusIcon.image = UIImage(systemName: "checkmark.circle.fill")
            statusIcon.tintColor = .brandGreen
            statusContainer.backgroundColor = .backgroundMint
            progressView.progress = 1.0
            progressView.progressTintColor = .brandGreen
        } else {
            let leftAmount = goal.targetAmount - goal.currentAmount
            let formattedLeftAmount = String(format: "%.0f", leftAmount)
            
            costLabel.text = "Cost: \(formattedTargetAmount) \(goal.currency)"
            leftAmountLabel.text = "Left: \(formattedLeftAmount) \(goal.currency)"
            leftAmountLabel.isHidden = false
            
            statusLabel.text = "Pay"
            statusLabel.textColor = .systemRed
            statusIcon.image = UIImage(systemName: "arrow.right")
            statusIcon.tintColor = .systemRed
            statusContainer.backgroundColor = .peachBackground
            progressView.progress = Float(goal.currentAmount / goal.targetAmount)
            progressView.progressTintColor = .systemBlue
        }
    }
}
