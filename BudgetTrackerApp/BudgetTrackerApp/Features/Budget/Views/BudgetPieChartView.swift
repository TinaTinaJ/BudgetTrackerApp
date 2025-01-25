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
        let status: String
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
            case "food":
                color = UIColor(red: 255/255, green: 178/255, blue: 178/255, alpha: 1)
            case "rent":
                color = UIColor(red: 208/255, green: 215/255, blue: 255/255, alpha: 1)
            case "loans":
                color = UIColor(red: 255/255, green: 220/255, blue: 178/255, alpha: 1)
            case "education":
                color = UIColor(red: 178/255, green: 223/255, blue: 255/255, alpha: 1)
            case "clothing":
                color = UIColor(red: 255/255, green: 178/255, blue: 255/255, alpha: 1)
            case "health":
                color = UIColor(red: 178/255, green: 255/255, blue: 218/255, alpha: 1)
            case "transport", "transportation":
                color = UIColor(red: 178/255, green: 255/255, blue: 218/255, alpha: 1)
            case "fun", "entertainment":
                color = UIColor(red: 255/255, green: 178/255, blue: 178/255, alpha: 1)
            case "subscriptions":
                color = UIColor(red: 178/255, green: 223/255, blue: 255/255, alpha: 1)
            case "bills":
                color = UIColor(red: 255/255, green: 178/255, blue: 255/255, alpha: 1)
            default:
                color = UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1)
            }
            
            return Segment(
                category: expense.category,
                value: expense.percentage,
                color: color,
                status: expense.status
            )
        }
        
        setNeedsDisplay()
    }
    
    override func draw(_ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext(),
              !segments.isEmpty else { return }
        
        let total = segments.reduce(0) { $0 + $1.value }
        let radius = min(bounds.width, bounds.height) * 0.45
        let center = CGPoint(x: bounds.midX, y: bounds.midY)
        
        var startAngle = -CGFloat.pi / 2
        
        context.saveGState()
        
        let backgroundPath = UIBezierPath(
            arcCenter: center,
            radius: radius,
            startAngle: 0,
            endAngle: 2 * .pi,
            clockwise: true
        )
        UIColor.white.setFill()
        backgroundPath.fill()
        
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
            
            let midAngle = startAngle + (endAngle - startAngle) / 2
            let labelRadius = radius * 0.65
            
            let labelPoint = CGPoint(
                x: center.x + cos(midAngle) * labelRadius,
                y: center.y + sin(midAngle) * labelRadius
            )
            
            let percentageString = "\(Int(segment.value))%"
            let attributes: [NSAttributedString.Key: Any] = [
                .font: UIFont.systemFont(ofSize: 12, weight: .medium),
                .foregroundColor: UIColor(white: 0.3, alpha: 1),
                .paragraphStyle: {
                    let style = NSMutableParagraphStyle()
                    style.alignment = .center
                    return style
                }()
            ]
            
            let labelSize = percentageString.size(withAttributes: attributes)
            let labelRect = CGRect(
                x: labelPoint.x - labelSize.width / 2,
                y: labelPoint.y - labelSize.height / 2,
                width: labelSize.width,
                height: labelSize.height
            )
            
            percentageString.draw(in: labelRect, withAttributes: attributes)
            
            startAngle = endAngle
        }
        
        context.restoreGState()
    }
}
