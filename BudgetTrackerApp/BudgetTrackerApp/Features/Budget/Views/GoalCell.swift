//
//  GoalCell.swift
//  BudgetTrackerApp
//
//  Created by Tiko on 19.01.25.
//
import UIKit

class GoalCell: UITableViewCell {
    static let identifier = "GoalCell"

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.textColor = .black
        return label
    }()

    private let progressLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .gray
        return label
    }()

    private let progressBar: UIProgressView = {
        let progressView = UIProgressView(progressViewStyle: .default)
        progressView.tintColor = .brandGreen
        return progressView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(titleLabel)
        contentView.addSubview(progressLabel)
        contentView.addSubview(progressBar)
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with goal: MockGoal) {
        titleLabel.text = goal.title
        progressLabel.text = "\(goal.currentAmount)/\(goal.targetAmount)"
        progressBar.progress = Float(goal.currentAmount / goal.targetAmount)
    }

    private func setupConstraints() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        progressLabel.translatesAutoresizingMaskIntoConstraints = false
        progressBar.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),

            progressLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            progressLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            progressLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),

            progressBar.topAnchor.constraint(equalTo: progressLabel.bottomAnchor, constant: 8),
            progressBar.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            progressBar.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            progressBar.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            progressBar.heightAnchor.constraint(equalToConstant: 4)
        ])
    }
}
