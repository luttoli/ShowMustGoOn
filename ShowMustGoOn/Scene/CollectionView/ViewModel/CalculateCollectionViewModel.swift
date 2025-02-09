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
        let formattedExpression = expression
        
        // % 연산자 처리 (NSExpression이 인식하지 못하므로 대체)
        if formattedExpression.contains("%") {
            return handleModuloOperation(expression: formattedExpression)
        }
        
        // 0으로 나누는 경우 감지
        let divideByZeroPattern = #"(/|÷)\s*0"#
        if let _ = expression.range(of: divideByZeroPattern, options: .regularExpression) {
            return "Error"
        }
        
        let mathExpression = NSExpression(format: formattedExpression)
        if let result = mathExpression.expressionValue(with: nil, context: nil) as? NSNumber {
            return result.stringValue
        } else {
            return "Error"
        }
    }
    
    // % 연산을 직접 처리하는 함수
    func handleModuloOperation(expression: String) -> String {
        let components = expression.split(separator: "%").map { String($0) }
        
        // 2개의 숫자가 있어야 함
        if components.count == 2,
           let left = Int(components[0]),
           let right = Int(components[1]),
           right != 0 { // 0으로 나누는 경우 방지
            return String(left % right)
        }
        
        return "Error"
    }
}
