//
//  AddViewModel.swift
//  ShowMustGoOn
//
//  Created by 김지훈 on 11/18/24.
//

import UIKit

class AddViewModel {
    // 섹션 데이터를 관리
    private(set) var categories: [AddModel] = [
        AddModel(id: UUID(),
                 categoryTitle: "T1",
                 checkItem: [
                    CheckItem(checkItemId: UUID(), checkItemTitle: "도란", isChecked: false),
                    CheckItem(checkItemId: UUID(), checkItemTitle: "오너", isChecked: false),
                    CheckItem(checkItemId: UUID(), checkItemTitle: "페이커", isChecked: true),
                    CheckItem(checkItemId: UUID(), checkItemTitle: "구마유시", isChecked: false),
                    CheckItem(checkItemId: UUID(), checkItemTitle: "케리아", isChecked: false),
                    ]
                ),
        ]
    
    // 데이터 변경 알림
    var onCategoriesUpdated: (() -> Void)?
    
    // section 추가
    func addCategory(_ categoryTitle: String) {
        guard !categoryTitle.isEmpty else { return } // 빈 값 방지
        let newCategory = AddModel(id: UUID(), categoryTitle: categoryTitle, checkItem: [])
        categories.append(newCategory)
        onCategoriesUpdated?() // 데이터 변경 알림
    }
    
    // section 삭제
    func deleteCategory(_ id: UUID) {
        categories.removeAll { $0.id == id }
        onCategoriesUpdated?() // 데이터 변경 알림
    }
    
    // checkItem(cell) 추가
    func addCheckItem(categoryId: UUID, checkItemTitle: String) {
        // 카테고리 찾기
        if let categoryIndex = categories.firstIndex(where: { $0.id == categoryId }) {
            let newCheckItem = CheckItem(checkItemId: UUID(), checkItemTitle: checkItemTitle, isChecked: false)
            categories[categoryIndex].checkItem.append(newCheckItem)
            onCategoriesUpdated?() // 데이터 변경 알림
        }
    }
    
    // checkItem(cell) 삭제 - 카테고리, item(cell) 순서 찾기
    func deleteCheckItem(categoryId: UUID, checkItemId: UUID) {
        if let categoryIndex = categories.firstIndex(where: { $0.id == categoryId }),
           let checkItemIndex = categories[categoryIndex].checkItem.firstIndex(where: { $0.checkItemId == checkItemId }) {
            categories[categoryIndex].checkItem.remove(at: checkItemIndex)
            onCategoriesUpdated?() // 데이터 변경 알림
        }
    }
    
    // checkItem(cell) 상태 토글
    func checkItemToggle(categoryId: UUID, checkItemId: UUID) {
        if let categoryIndex = categories.firstIndex(where: { $0.id == categoryId }),
           let checkItemIndex = categories[categoryIndex].checkItem.firstIndex(where: { $0.checkItemId == checkItemId }) {
            categories[categoryIndex].checkItem[checkItemIndex].isChecked.toggle()
            onCategoriesUpdated?() // 변경 알림
        }
    }
}
