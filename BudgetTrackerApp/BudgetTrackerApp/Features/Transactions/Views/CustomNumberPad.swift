//
//  CustomNumberPad.swift
//  BudgetTrackerApp
//
//  Created by Tiko on 19.01.25.
//
import UIKit

protocol CustomNumberPadDelegate: AnyObject {
    func numberPadDidEnterValue(_ value: String)
    func numberPadDidClear()
    func numberPadReset()
}

class CustomNumberPad: UIView {
    
    weak var delegate: CustomNumberPadDelegate?
    private var currentInput: String = "0"
    private var hasDecimalPoint: Bool = false
    
    private let buttonTitles = [
        ["1", "2", "3", "+"],
        ["4", "5", "6", "-"],
        ["7", "8", "9", "="],
        ["C", "0", ".", "⌫"]
    ]
    
    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 8
        stack.distribution = .fillEqually
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        backgroundColor = .customLightGray
        layer.cornerRadius = 12
        
        addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)
        ])
        
        setupButtons()
    }
    
    private func setupButtons() {
        buttonTitles.forEach { row in
            let rowStack = UIStackView()
            rowStack.axis = .horizontal
            rowStack.spacing = 8
            rowStack.distribution = .fillEqually
            
            row.forEach { title in
                let button = createButton(withTitle: title)
                rowStack.addArrangedSubview(button)
            }
            
            stackView.addArrangedSubview(rowStack)
        }
    }
    
    private func createButton(withTitle title: String) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20)
        button.backgroundColor = .white
        button.layer.cornerRadius = 8
        
        switch title {
        case "+", "-", "=", "⌫", "C":
            button.setTitleColor(.systemBlue, for: .normal)
        default:
            button.setTitleColor(.black, for: .normal)
        }
        
        button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        return button
    }
    
    @objc private func buttonTapped(_ sender: UIButton) {
        guard let title = sender.title(for: .normal) else { return }
        
        switch title {
        case "C":
            reset()
            
        case "⌫":
            if currentInput.count > 1 {
                let lastChar = String(currentInput.last!)
                currentInput.removeLast()
                if lastChar == "." {
                    hasDecimalPoint = false
                }
            } else {
                currentInput = "0"
            }
            delegate?.numberPadDidEnterValue(currentInput)
            
        case "+", "-", "=":
            break
            
        case ".":
            if !hasDecimalPoint {
                currentInput += title
                hasDecimalPoint = true
                delegate?.numberPadDidEnterValue(currentInput)
            }
            
        default:
            if currentInput == "0" {
                currentInput = title
            } else {
                if currentInput.count < 10 {
                    currentInput += title
                }
            }
            delegate?.numberPadDidEnterValue(currentInput)
        }
    }
    
    func reset() {
        currentInput = "0"
        hasDecimalPoint = false
        delegate?.numberPadDidClear()
        delegate?.numberPadReset()
    }
}
