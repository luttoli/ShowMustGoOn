//
//  AddModel.swift
//  ShowMustGoOn
//
//  Created by 김지훈 on 11/18/24.
//

import UIKit

struct AddTableModel {
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

struct AddTableSection {
    var id: UUID // 각 섹션의 고유 ID
    var header: String
    var items: [Item]
    
    init(id: UUID = UUID(), header: String, items: [Item]) {
        self.id = id
        self.header = header
        self.items = items
    }
}

extension AddTableSection: SectionModelType {
    typealias Item = CheckItem
    
    init(original: AddTableSection, items: [Item]) {
        self = original
        self.items = items
    }
}
