//
//  ViewController.swift
//  Calculator
//
//  Created by Илья on 24.02.2024.
//

import UIKit

final class ViewController: UIViewController {
// MARK: - IB Outlets
    @IBOutlet weak var displayValue: UILabel!
    @IBOutlet weak var displayExpression: UILabel!
    
    @IBOutlet var buttons: [UIButton]!
    
// MARK: - View Life Cycle
    private var operandOne: Double = 0
    private var operandTwo: Double = 0
    private var operation = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        displayValue.layer.cornerRadius = 13
        displayValue.layer.masksToBounds = true
        
        displayExpression.layer.cornerRadius = 13
        displayExpression.layer.masksToBounds = true
        
        for button in buttons {
            button.addTarget(self, action: #selector(pressButtonNumber(_:)), for: .touchUpInside)
        }
    }

// MARK: - IB Actions
    @IBAction func pressButtonNumber(_ sender: UIButton) {
        if let index = buttons.firstIndex(of: sender) {
            if index == 10 {
                displayValue.text = signRecording(".", displayValue)
                displayExpression.text = signRecording(".", displayExpression)
            } else {
                displayValue.text = signRecording(index.formatted(), displayValue)
                displayExpression.text = signRecording(index.formatted(), displayExpression)
            }
        }
    }
    
    @IBAction func pressButtonOperand(_ sender: UIButton) {
        if operandOne == 0 {
            operandOne = Double(String(displayValue.text ?? "")) ?? 0
        }
        
        switch sender.tag {
        case 1: 
            operation = "+"
            displayExpression.text = signRecording(" \(operation) ", displayExpression)
        case 2:
            operation = "-"
            displayExpression.text = signRecording(" \(operation) ", displayExpression)
        case 3:
            operation = "*"
            displayExpression.text = signRecording(" \(operation) ", displayExpression)
        case 4:
            operation = "/"
            displayExpression.text = signRecording(" \(operation) ", displayExpression)
        default: break
        }
        
        displayValue.text = ""
    }
    
    @IBAction func allClean() {
        operandOne = 0
        operandTwo = 0
        operation = ""
        displayValue.text = ""
        displayExpression.text = ""
    }
    
    @IBAction func resultAction() {
        operandTwo = Double(String(displayValue.text ?? "")) ?? 0
        displayValue.text = getResult(operandOne, operandTwo, operation).0
        operandOne = getResult(operandOne, operandTwo, operation).1
    }

// MARK: - Private method
    private func getResult(_ numOne: Double, _ numTwo: Double,_ operation: String) -> (String, Double) {
        switch operation {
        case "+": 
            return (String(numOne + numTwo), numOne + numTwo)
        case "-": 
            return (String(numOne - numTwo), numOne - numTwo)
        case "/": 
            guard numTwo != 0 else { return ("На ноль делить нельзя!!", 0 )}
            return (String(numOne / numTwo), numOne / numTwo)
        case "*": 
            return (String(numOne * numTwo), numOne * numTwo)
        default: 
            return ("Error", 0)
        }
    }
    
    private func signRecording(_ value: String, _ label: UILabel!) -> String {
        if let text = label.text {
            return text + value
        } else {
            return value
        }
    }
}
