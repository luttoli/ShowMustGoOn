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
}
