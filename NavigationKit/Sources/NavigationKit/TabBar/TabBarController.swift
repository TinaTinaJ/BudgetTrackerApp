//
//  TabBarController.swift
//  NavigationKit
//
//  Created by Tiko on 25.01.25.
//
#if canImport(UIKit)
import UIKit

public class TabBarController: UITabBarController {
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupAppearance()
    }
    
    private func setupAppearance() {
        tabBar.backgroundColor = .systemBackground
        tabBar.tintColor = .systemBlue
    }
    
    public func setTabs(_ viewControllers: [UIViewController]) {
        self.viewControllers = viewControllers
    }
}
#endif
