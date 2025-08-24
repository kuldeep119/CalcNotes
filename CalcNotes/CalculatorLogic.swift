//
//  CalculatorLogic.swift
//  CalcNotes
//
//  Created by Kuldeep singh on 24/08/25.
//

import Foundation

struct CalculatorLogic {
    static func numberTapped(current: String, number: String) -> String {
        if current == "0" || current == "-0" {
            return number
        } else if let last = current.last, "+-*/".contains(last) {
            return current + number
        } else {
            return current + number
        }
    }
    
    static func operationTapped(current: String, operation: String) -> String {
        var display = current
        if let last = display.last, "+-*/".contains(last) {
            display.removeLast()
        }
        display += " \(operation) "
        return display
    }
    
    static func equalsTapped(display: String) -> String? {
        let expression = display.replacingOccurrences(of: "÷", with: "/")
        let exp = NSExpression(format: expression)
        
        if let result = exp.expressionValue(with: nil, context: nil) as? NSNumber {
            return String(result.doubleValue.clean())
        }
        return nil
    }
}
