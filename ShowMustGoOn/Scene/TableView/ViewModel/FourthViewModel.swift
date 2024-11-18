//
//  FourthViewModel.swift
//  ShowMustGoOn
//
//  Created by 김지훈 on 11/18/24.
//

import UIKit

class FourthViewModel {
    // 섹션 데이터를 관리
    private(set) var categories: [MemoModel] = []
    
    // 데이터 변경 알림
    var onCategoriesUpdated: (() -> Void)?
    
    // addItem
    func addItem(_ category: String, _ item: String) {
        guard !category.isEmpty, !item.isEmpty else { return }
        let newItem = MemoModel(id: UUID(), categoryTitle: category, itemTitle: item, itemCompleted: Bool())
        categories.append(newItem)
        onCategoriesUpdated?()
    }
    
    // 카테고리 추가 메서드
    func addCategory(_ category: String) {
        guard !category.isEmpty else { return } // 빈 값 방지
        let newCategory = MemoModel(id: UUID(), categoryTitle: category, itemTitle: String(), itemCompleted: Bool())
        categories.append(newCategory)
        onCategoriesUpdated?() // 데이터 변경 알림
    }
    
    // 카테고리 삭제 메서드
    func deleteCategory(_ id: UUID) {
        categories.removeAll { $0.id == id }
        onCategoriesUpdated?() // 데이터 변경 알림
    }
}

