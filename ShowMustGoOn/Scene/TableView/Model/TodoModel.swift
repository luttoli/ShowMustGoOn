//
//  TodoModel.swift
//  ShowMustGoOn
//
//  Created by 김지훈 on 12/19/24.
//

import UIKit

struct TodoModel {
    let title: String
    var isCompleted: Bool = false
}

// RxTodoCellData
struct RxTodoCellData {
    let title: String
    var isCompleted: Bool
    var textColor: UIColor
}
