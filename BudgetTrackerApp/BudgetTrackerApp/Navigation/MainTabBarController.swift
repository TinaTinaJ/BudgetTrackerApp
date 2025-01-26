//
//  MainTabBarController.swift
//  BudgetTrackerApp
//
//  Created by Tiko on 18.01.25.
//
import UIKit
import SwiftUI
import NavigationKit

class MainTabBarController: NavigationKit.MainTabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(red: 0/255, green: 81/255, blue: 61/255, alpha: 1)
        
        let borderColor = UIColor(red: 112/255, green: 121/255, blue: 116/255, alpha: 1)
        appearance.shadowColor = borderColor
        
        tabBar.standardAppearance = appearance
        if #available(iOS 15.0, *) {
            tabBar.scrollEdgeAppearance = appearance
        }
        
        tabBar.tintColor = .white
        tabBar.unselectedItemTintColor = borderColor
        
        let dashboardView = UIHostingController(rootView: DashboardView())
        dashboardView.tabBarItem = createTabBarItem(
            title: "Dashboard",
            image: "house.fill",
            tag: 0
        )
        
        let budgetView = BudgetViewController()
        budgetView.tabBarItem = createTabBarItem(
            title: "Budget",
            image: "chart.pie.fill",
            tag: 1
        )
        
        let addTransactionView = AddTransactionViewController()
        addTransactionView.tabBarItem = createTabBarItem(
            title: "Add",
            image: "plus.circle.fill",
            tag: 2
        )
        
        let moreView = MoreMenuHostingController(rootView: MoreMenuView())
        moreView.tabBarItem = createTabBarItem(
            title: "More",
            image: "ellipsis.circle.fill",
            tag: 3
        )
        
        viewControllers = [dashboardView, budgetView, addTransactionView, moreView]
    }
    
    private func createTabBarItem(title: String, image: String, tag: Int) -> UITabBarItem {
        let item = UITabBarItem(
            title: title,
            image: UIImage(systemName: image),
            tag: tag
        )
        
        let normalAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor(red: 112/255, green: 121/255, blue: 116/255, alpha: 1),
            .font: UIFont.systemFont(ofSize: 12)
        ]
        
        let selectedAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.white,
            .font: UIFont.systemFont(ofSize: 12)
        ]
        
        item.setTitleTextAttributes(normalAttributes, for: .normal)
        item.setTitleTextAttributes(selectedAttributes, for: .selected)
        
        item.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
        
        return item
    }
}
