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

//
import RxDataSources

struct AddSection {
    var id: UUID // 각 섹션의 고유 ID
    var header: String
    var items: [Item]
    
    init(id: UUID = UUID(), header: String, items: [Item]) {
        self.id = id
        self.header = header
        self.items = items
    }
}

extension AddSection: SectionModelType {
    typealias Item = CheckItem
    
    init(original: AddSection, items: [Item]) {
        self = original
        self.items = items
    }
}
