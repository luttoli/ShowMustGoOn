//
//  AddModel.swift
//  ShowMustGoOn
//
//  Created by 김지훈 on 11/18/24.
//

import UIKit

struct AddModel {
    let id: UUID
    let categoryTitle: String
    var checkItem: [CheckItem]
}

struct CheckItem {
    let checkItemId: UUID
    let checkItemTitle: String
    var isChecked: Bool
}
