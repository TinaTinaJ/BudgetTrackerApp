//
//  BudgetPieChartView.swift
//  BudgetTrackerApp
//
//  Created by Tiko on 21.01.25.
//

import UIKit

final class BudgetPieChartView: UIView {
    
    struct Segment {
        let category: String
        let value: Double
        let color: UIColor
    }
    
    private var segments: [Segment] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with expenses: [MockExpense]) {
        segments = expenses.map { expense in
            let color: UIColor
            switch expense.category.lowercased() {
            case "health":
                color = .brandGreen
            case "education":
                color = .darkBlue
            case "loans":
                color = .lightOrange
            case "bills":
                color = .peachBorder
            case "subscriptions":
                color = .lightBlue
            default:
                color = .systemGray
            }
            
            return Segment(
                category: expense.category,
                value: expense.percentage,
                color: color
            )
        }
        
        setNeedsDisplay()
    }
    
    override func draw(_ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext(),
              !segments.isEmpty else { return }
        
        let total = segments.reduce(0) { $0 + $1.value }
        let radius = min(bounds.width, bounds.height) * 0.5
        let center = CGPoint(x: bounds.midX, y: bounds.midY)
        
        var startAngle = -CGFloat.pi / 2
        
        for segment in segments {
            let endAngle = startAngle + (CGFloat(segment.value / total) * 2 * .pi)
            
            let path = UIBezierPath()
            path.move(to: center)
            path.addArc(
                withCenter: center,
                radius: radius,
                startAngle: startAngle,
                endAngle: endAngle,
                clockwise: true
            )
            path.close()
            
            segment.color.setFill()
            path.fill()
            
            startAngle = endAngle
        }
    }
}
