//
//  CalculateCollectionViewModel.swift
//  ShowMustGoOn
//
//  Created by 김지훈 on 1/31/25.
//

import UIKit

class CalculateCollectionViewModel {
    var keypad: CalculateCollectionModel = CalculateCollectionModel(calculateKey: [
        "AC", "⌫", "%", "/",
        "7", "8", "9", "*",
        "4", "5", "6", "-",
        "1", "2", "3", "+",
        "🧮", "0", ".", "="
    ])

    // 계산식
    func calculation(_ expression: String) -> String {
        // 0으로 나누는 경우 감지
        let divideByZeroPattern = #"(/|÷)\s*0"#
        if let _ = expression.range(of: divideByZeroPattern, options: .regularExpression) {
            return "Error"
        }
        
        let mathExpression = NSExpression(format: expression)
        if let result = mathExpression.expressionValue(with: nil, context: nil) as? NSNumber {
            return result.stringValue
        } else {
            return "Error"
        }
    }
}
