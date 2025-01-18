//
//  TabBarController.swift
//  BudgetTrackerApp
//
//  Created by Tiko on 18.01.25.
//
import UIKit
import SwiftUI

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let dashboardVC = UIHostingController(rootView: DashboardView())
        dashboardVC.tabBarItem = UITabBarItem(title: "Dashboard", image: UIImage(systemName: "house.fill"), tag: 0)

        let budgetVC = BudgetViewController()
        budgetVC.tabBarItem = UITabBarItem(title: "Budget", image: UIImage(systemName: "chart.pie.fill"), tag: 1)

        let addTransactionVC = AddTransactionViewController()
        addTransactionVC.tabBarItem = UITabBarItem(title: "Add", image: UIImage(systemName: "plus.circle.fill"), tag: 2)

        let advicesVC = UIHostingController(rootView: AdvicesView())
        advicesVC.tabBarItem = UITabBarItem(title: "Advices", image: UIImage(systemName: "lightbulb.fill"), tag: 3)

        let moreVC = MoreViewController()
        moreVC.tabBarItem = UITabBarItem(title: "More", image: UIImage(systemName: "ellipsis.circle.fill"), tag: 4)

        viewControllers = [dashboardVC, budgetVC, addTransactionVC, advicesVC, moreVC]
    }
}

