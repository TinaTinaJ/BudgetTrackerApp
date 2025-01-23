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
        
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(red: 0/255, green: 33/255, blue: 23/255, alpha: 1)
        
        let borderColor = UIColor(red: 112/255, green: 121/255, blue: 116/255, alpha: 1)
        appearance.shadowColor = borderColor
        
        tabBar.standardAppearance = appearance
        if #available(iOS 15.0, *) {
            tabBar.scrollEdgeAppearance = appearance
        }
        
        tabBar.tintColor = .white
        tabBar.unselectedItemTintColor = borderColor
        
        let dashboardVC = UIHostingController(rootView: DashboardView())
        configureTabBarItem(for: dashboardVC, title: "Dashboard", image: "house.fill", tag: 0)
        
        let budgetVC = BudgetViewController()
        configureTabBarItem(for: budgetVC, title: "Budget", image: "chart.pie.fill", tag: 1)
        
        let addTransactionVC = AddTransactionViewController()
        configureTabBarItem(for: addTransactionVC, title: "Add", image: "plus.circle.fill", tag: 2)
        
        let advicesVC = UIHostingController(rootView: AdvicesView())
        configureTabBarItem(for: advicesVC, title: "Advices", image: "lightbulb.fill", tag: 3)
        
        let moreVC = MoreMenuHostingController(rootView: MoreMenuView())
        configureTabBarItem(for: moreVC, title: "More", image: "ellipsis.circle.fill", tag: 4)
        
        viewControllers = [dashboardVC, budgetVC, addTransactionVC, advicesVC, moreVC]
    }
    
    private func configureTabBarItem(for viewController: UIViewController, title: String, image: String, tag: Int) {
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
        
        viewController.tabBarItem = item
    }
}
