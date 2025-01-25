//
//  MainTabBarController.swift
//  NavigationKit
//
//  Created by Tiko on 25.01.25.
//

#if canImport(UIKit)
import UIKit

public class MainTabBarController: UITabBarController {
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupTabs()
        setupAppearance()
    }
    
    private func setupTabs() {
        // We'll leave this empty for now - your app will fill this
    }
    
    private func setupAppearance() {
        tabBar.backgroundColor = .systemBackground
        tabBar.tintColor = .systemBlue  // You can change this color
    }
}
#endif
