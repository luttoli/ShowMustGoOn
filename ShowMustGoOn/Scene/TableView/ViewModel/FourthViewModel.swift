//
//  FourthViewModel.swift
//  ShowMustGoOn
//
//  Created by 김지훈 on 11/18/24.
//

import UIKit

class FourthViewModel {
    // 섹션 데이터를 관리
    private(set) var categories: [MemoModel] = [
        MemoModel(id: UUID(), categoryTitle: "T1", items: [
            Item(id: UUID(), title: "도란", isChecked: false),
            Item(id: UUID(), title: "오너", isChecked: false),
            Item(id: UUID(), title: "페이커", isChecked: true),
            Item(id: UUID(), title: "구마유시", isChecked: false),
            Item(id: UUID(), title: "케리아", isChecked: false),
        ])
    ]
    
    // 데이터 변경 알림
    var onCategoriesUpdated: (() -> Void)?
    
    // 항목 추가
    func addItem(categoryId: UUID, itemTitle: String) {
        // 카테고리 찾기
        if let categoryIndex = categories.firstIndex(where: { $0.id == categoryId }) {
            let newItem = Item(id: UUID(), title: itemTitle, isChecked: false)
            categories[categoryIndex].items.append(newItem)
            onCategoriesUpdated?() // 데이터 변경 알림
        }
    }
    
    // 항목 삭제
    func deleteItem(categoryId: UUID, itemTitle: String) {
        if let categoryIndex = categories.firstIndex(where: { $0.id == categoryId }) {
            // items 배열에서 title 비교
            if let itemIndex = categories[categoryIndex].items.firstIndex(where: { $0.title == itemTitle }) {
                categories[categoryIndex].items.remove(at: itemIndex)
                onCategoriesUpdated?() // 데이터 변경 알림
            }
        }
    }
    
    // 항목 상태 업데이트
    func toggleItemCheck(categoryId: UUID, itemId: UUID) {
        if let categoryIndex = categories.firstIndex(where: { $0.id == categoryId }),
           let itemIndex = categories[categoryIndex].items.firstIndex(where: { $0.id == itemId }) {
            categories[categoryIndex].items[itemIndex].isChecked.toggle()
            onCategoriesUpdated?() // 변경 알림
        }
    }
    
    // 카테고리 추가
    func addCategory(_ categoryTitle: String) {
        guard !categoryTitle.isEmpty else { return } // 빈 값 방지
        let newCategory = MemoModel(id: UUID(), categoryTitle: categoryTitle, items: [])
        categories.append(newCategory)
        onCategoriesUpdated?() // 데이터 변경 알림
    }
    
    // 카테고리 삭제
    func deleteCategory(_ id: UUID) {
        categories.removeAll { $0.id == id }
        onCategoriesUpdated?() // 데이터 변경 알림
    }
}
