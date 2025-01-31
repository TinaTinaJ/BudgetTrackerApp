//
//  BudgetViewController.swift
//  BudgetTrackerApp
//
//  Created by Tiko on 18.01.25.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
import FirebaseCore

final class BudgetViewController: UIViewController {
    
    private var selectedTab: Int = 0 {
        didSet {
            collectionView.reloadData()
        }
    }
    
    private let mockData = MockDataProvider.shared
    
    private let headerView: UIView = {
        let view = UIView()
        view.backgroundColor = .backgroundMint
        return view
    }()
    
    private let segmentedControl: UISegmentedControl = {
        let control = UISegmentedControl(items: ["Transactions", "Expenses", "Goals"])
        control.selectedSegmentIndex = 0
        control.backgroundColor = .customLightGray
        control.selectedSegmentTintColor = .backgroundMint
        let normalTextAttributes: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.black]
        let selectedTextAttributes: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.brandGreen]
        control.setTitleTextAttributes(normalTextAttributes, for: .normal)
        control.setTitleTextAttributes(selectedTextAttributes, for: .selected)
        return control
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = createLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .backgroundMint
        cv.delegate = self
        cv.dataSource = self
        cv.register(TransactionCell.self, forCellWithReuseIdentifier: TransactionCell.identifier)
        cv.register(ExpenseCell.self, forCellWithReuseIdentifier: ExpenseCell.identifier)
        cv.register(ExpenseChartCell.self, forCellWithReuseIdentifier: ExpenseChartCell.identifier)
        cv.register(ExpenseToBePaidCell.self, forCellWithReuseIdentifier: ExpenseToBePaidCell.identifier)
        cv.register(GoalCell.self, forCellWithReuseIdentifier: GoalCell.identifier)
        cv.register(AddGoalCell.self, forCellWithReuseIdentifier: AddGoalCell.identifier)
        return cv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
        loadGoals()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if selectedTab == 2 {
            collectionView.reloadData()
        }
    }
    
    private func setupUI() {
        title = "Budget"
        view.backgroundColor = .backgroundMint
        navigationController?.navigationBar.prefersLargeTitles = true
        
        segmentedControl.addTarget(self, action: #selector(segmentChanged), for: .valueChanged)
        
        view.addSubview(headerView)
        view.addSubview(segmentedControl)
        view.addSubview(collectionView)
    }
    
    private func setupConstraints() {
        [headerView, segmentedControl, collectionView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 60),
            
            segmentedControl.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
            segmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            segmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            segmentedControl.heightAnchor.constraint(equalToConstant: 32),
            
            collectionView.topAnchor.constraint(equalTo: headerView.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func loadGoals() {
        guard let userId = Auth.auth().currentUser?.uid else { return }
        
        let db = Firestore.firestore()
        db.collection("users")
            .document(userId)
            .collection("goals")
            .getDocuments { [weak self] snapshot, error in
                if let error = error {
                    print("Error loading goals: \(error.localizedDescription)")
                    return
                }
                
                if let documents = snapshot?.documents {
                    let firebaseGoals = documents.compactMap { document in
                        let data = document.data()
                        return MockGoal(
                            id: data["id"] as? String ?? "",
                            title: data["title"] as? String ?? "",
                            icon: data["icon"] as? String ?? "star.fill",
                            currentAmount: data["currentAmount"] as? Double ?? 0.0,
                            targetAmount: data["targetAmount"] as? Double ?? 0.0,
                            status: data["status"] as? String ?? "Unpaid",
                            currency: data["currency"] as? String ?? "GEL"
                        )
                    }
                    
                    self?.mockData.goals = MockDataProvider.shared.goals + firebaseGoals
                    
                    DispatchQueue.main.async {
                        self?.collectionView.reloadData()
                    }
                }
            }
    }
    
    private func createLayout() -> UICollectionViewLayout {
        UICollectionViewCompositionalLayout { [weak self] section, _ in
            guard let self = self else { return nil }
            
            switch self.selectedTab {
            case 0: return self.createTransactionsLayout()
            case 1: return self.createExpensesLayout()
            case 2: return self.createGoalsLayout()
            default: return nil
            }
        }
    }
    
    private func createTransactionsLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(80)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(80)
        )
        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: groupSize,
            subitems: [item]
        )
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 8
        section.contentInsets = NSDirectionalEdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16)
        
        return section
    }
    
    private func createExpensesLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(80)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(80)
        )
        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: groupSize,
            subitems: [item]
        )
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 12
        section.contentInsets = NSDirectionalEdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16)
        
        return section
    }
    
    private func createGoalsLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.5),
            heightDimension: .absolute(160)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 8)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(160)
        )
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitems: [item]
        )
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 16
        section.contentInsets = NSDirectionalEdgeInsets(top: 16, leading: 8, bottom: 16, trailing: 8)
        
        return section
    }
    
    @objc private func segmentChanged() {
        selectedTab = segmentedControl.selectedSegmentIndex
        collectionView.setCollectionViewLayout(createLayout(), animated: true)
    }
}

extension BudgetViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch selectedTab {
        case 0:
            return mockData.transactions.count
        case 1:
            return mockData.expenses.count + 2
        case 2:
            return mockData.goals.count + 1
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch selectedTab {
        case 0:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: TransactionCell.identifier,
                for: indexPath
            ) as! TransactionCell
            cell.configure(with: mockData.transactions[indexPath.item])
            return cell
            
        case 1:
            if indexPath.item == 0 {
                let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: ExpenseChartCell.identifier,
                    for: indexPath
                ) as! ExpenseChartCell
                cell.configure(with: mockData.expenses)
                return cell
            } else if indexPath.item == 1 {
                let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: ExpenseToBePaidCell.identifier,
                    for: indexPath
                ) as! ExpenseToBePaidCell
                cell.configure(with: mockData.expenses)
                return cell
            } else {
                let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: ExpenseCell.identifier,
                    for: indexPath
                ) as! ExpenseCell
                cell.configure(with: mockData.expenses[indexPath.item - 2])
                return cell
            }
            
        case 2:
            if indexPath.item == mockData.goals.count {
                let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: AddGoalCell.identifier,
                    for: indexPath
                ) as! AddGoalCell
                return cell
            } else {
                let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: GoalCell.identifier,
                    for: indexPath
                ) as! GoalCell
                cell.delegate = self  // Add this line
                cell.configure(with: mockData.goals[indexPath.item])
                return cell
            }
            
        default:
            return UICollectionViewCell()
        }
    }
}

extension BudgetViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if selectedTab == 2 && indexPath.item == mockData.goals.count {
            let addGoalVC = AddGoalHostingController(mockData: mockData)
            addGoalVC.modalPresentationStyle = .formSheet
            present(addGoalVC, animated: true) { [weak self] in
                self?.collectionView.reloadData()
            }
        }
    }
}

extension BudgetViewController: GoalCellDelegate {
    func didTapDeleteButton(for goal: MockGoal) {
        deleteGoal(goal)
    }
    
    func didLongPressGoal(_ goal: MockGoal) {
    }
    
    private func deleteGoal(_ goal: MockGoal) {
        guard let userId = Auth.auth().currentUser?.uid else { return }
        
        let db = Firestore.firestore()
        db.collection("users")
            .document(userId)
            .collection("goals")
            .document(goal.id)
            .delete { [weak self] error in
                guard let self = self else { return }
                
                DispatchQueue.main.async {
                    if let error = error {
                        print("Error deleting goal: \(error.localizedDescription)")
                        let alert = UIAlertController(
                            title: "Error",
                            message: "Failed to delete goal. Please try again.",
                            preferredStyle: .alert
                        )
                        alert.addAction(UIAlertAction(title: "OK", style: .default))
                        self.present(alert, animated: true)
                        return
                    }
                    
                    if let index = self.mockData.goals.firstIndex(where: { $0.id == goal.id }) {
                        self.mockData.goals.remove(at: index)
                        self.collectionView.reloadData()
                    }
                }
            }
    }
}
