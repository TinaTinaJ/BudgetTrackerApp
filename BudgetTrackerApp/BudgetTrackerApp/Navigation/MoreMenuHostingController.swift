//
//  MoreMenuHostingController.swift
//  BudgetTrackerApp
//
//  Created by Tiko on 23.01.25.
//
import UIKit
import SwiftUI
import NavigationKit

class MoreMenuHostingController: NavigationKit.MoreMenuHostingController<MoreMenuView> {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(rootView: MoreMenuView) {
        super.init(rootView: rootView)
    }
}
