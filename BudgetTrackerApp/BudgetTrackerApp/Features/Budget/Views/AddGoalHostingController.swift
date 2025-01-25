//
//  AddGoalHostingController.swift
//  BudgetTrackerApp
//
//  Created by Tiko on 25.01.25.
//
import SwiftUI

class AddGoalHostingController: UIHostingController<AddGoalView> {
    init(mockData: MockDataProvider) {
        super.init(rootView: AddGoalView(mockData: mockData))
        
        self.modalPresentationStyle = .formSheet
        self.isModalInPresentation = false
        
        if let sheet = self.sheetPresentationController {
            sheet.detents = [.medium()]
            sheet.prefersGrabberVisible = true
        }
    }
    
    @MainActor required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .backgroundMint
    }
}
