//
//  MemoModel.swift
//  ShowMustGoOn
//
//  Created by 김지훈 on 11/18/24.
//

import UIKit

struct MemoModel {
    let id: UUID
    let categoryTitle: String
    var itemTitle: [String]
    let itemCompleted: [Bool]
}