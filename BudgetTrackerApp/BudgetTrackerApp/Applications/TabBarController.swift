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
        
        // Set the tab bar's background color
        tabBar.barTintColor = UIColor(named: "TabBarBackgroundColor") ?? UIColor.systemBackground
        tabBar.isTranslucent = false
        
        // Set the tint color for selected icons
        tabBar.tintColor = UIColor.white
        tabBar.unselectedItemTintColor = UIColor.lightGray

        // Configure each tab with its view controller and tab bar item
        let dashboardVC = UIHostingController(rootView: DashboardView())
        dashboardVC.tabBarItem = UITabBarItem(
            title: "Dashboard",
            image: UIImage(systemName: "house.fill"),
            selectedImage: UIImage(systemName: "house.fill")
        )
        
        let budgetVC = BudgetViewController()
        budgetVC.tabBarItem = UITabBarItem(
            title: "Budget",
            image: UIImage(systemName: "chart.pie.fill"),
            selectedImage: UIImage(systemName: "chart.pie.fill")
        )

        let addTransactionVC = AddTransactionViewController()
        addTransactionVC.tabBarItem = UITabBarItem(
            title: "Add",
            image: UIImage(systemName: "plus.circle.fill"),
            selectedImage: UIImage(systemName: "plus.circle.fill")
        )

        let advicesVC = UIHostingController(rootView: AdvicesView())
        advicesVC.tabBarItem = UITabBarItem(
            title: "Advices",
            image: UIImage(systemName: "lightbulb.fill"),
            selectedImage: UIImage(systemName: "lightbulb.fill")
        )

        let moreVC = MoreViewController()
        moreVC.tabBarItem = UITabBarItem(
            title: "More",
            image: UIImage(systemName: "ellipsis.circle.fill"),
            selectedImage: UIImage(systemName: "ellipsis.circle.fill")
        )

        // Assign the view controllers to the tab bar
        viewControllers = [dashboardVC, budgetVC, addTransactionVC, advicesVC, moreVC]
    }
}
