//
//  MainTabBarController.swift
//  BudgetTrackerApp
//
//  Created by Tiko on 18.01.25.
//
import UIKit
import SwiftUI

class MainTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()

        let dashboardView = UIHostingController(rootView: DashboardView())
        dashboardView.tabBarItem = UITabBarItem(title: "Dashboard", image: UIImage(systemName: "house.fill"), tag: 0)

        let budgetView = BudgetViewController()
        budgetView.tabBarItem = UITabBarItem(title: "Budget", image: UIImage(systemName: "chart.pie.fill"), tag: 1)

        let addTransactionView = AddTransactionViewController()
        addTransactionView.tabBarItem = UITabBarItem(title: "Add", image: UIImage(systemName: "plus.circle.fill"), tag: 2)

        let moreView = MoreViewController()
        moreView.tabBarItem = UITabBarItem(title: "More", image: UIImage(systemName: "ellipsis.circle.fill"), tag: 3)

        viewControllers = [dashboardView, budgetView, addTransactionView, moreView]
    }
}

