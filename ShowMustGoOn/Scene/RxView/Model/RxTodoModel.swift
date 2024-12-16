//
//  RxTodoModel.swift
//  ShowMustGoOn
//
//  Created by 김지훈 on 12/14/24.
//

import UIKit

struct RxTodoModel {
    let title: String
    var isCompleted: Bool = false
}

// RxTodoCellData
struct RxTodoCellData {
    let title: String
    var isCompleted: Bool    
    var textColor: UIColor
}
