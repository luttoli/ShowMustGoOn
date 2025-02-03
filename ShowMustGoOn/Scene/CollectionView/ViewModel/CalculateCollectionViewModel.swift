//
//  CalculateCollectionViewModel.swift
//  ShowMustGoOn
//
//  Created by 김지훈 on 1/31/25.
//

import UIKit

class CalculateCollectionViewModel {
    var keypad: CalculateCollectionModel = CalculateCollectionModel(calculateNumberKey: [
        "AC", "⌫", "%", "/",
        "7", "8", "9", "*",
        "4", "5", "6", "-",
        "1", "2", "3", "+",
        "🧮", "0", ".", "="
    ])
    
    // 현재 입력 중인 숫자
    var currentInput: String = "0"
    
    // 이전 숫자 저장 (연산할 때 사용)
    var previousNumber: String?
    
    // 선택된 연산자 저장
    var selectedOperator: String?
    
//    func cal(previousNumber: String, operators: String, currentInput: String, result: String) {
//        switch operators {
//        case "+":
//            Int(previousNumber + currentInput)
//        case "-":
//            print("-")
//        case "*":
//            print("*")
//        case "/":
//            print("/")
//        default:
//            print("")
//        }
//    }
    
    
    func calculate(_ num1: String, _ op: String, _ num2: String) -> String {
        guard let first = Double(num1), let second = Double(num2) else { return "Error" }

        switch op {
        case "+": return String(first + second)
        case "-": return String(first - second)
        case "*": return String(first * second)
        case "/": return second == 0 ? "Error" : String(first / second)
        default: return "Error"
        }
    }
    
    
    

    
    
    
    
}
