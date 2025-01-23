//
//  MoreMenuHostingController.swift
//  BudgetTrackerApp
//
//  Created by Tiko on 23.01.25.
//
import UIKit
import SwiftUI

class MoreMenuHostingController: UIHostingController<MoreMenuView> {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder, rootView: MoreMenuView())
    }
    
    override init(rootView: MoreMenuView) {
        super.init(rootView: rootView)
    }
}
