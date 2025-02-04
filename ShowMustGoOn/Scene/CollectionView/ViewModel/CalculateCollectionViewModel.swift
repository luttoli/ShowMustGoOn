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
        let mathExpression = NSExpression(format: expression)
        if let result = mathExpression.expressionValue(with: nil, context: nil) as? NSNumber {
            return result.stringValue
        } else {
            return "Error"
        }
    }
}
