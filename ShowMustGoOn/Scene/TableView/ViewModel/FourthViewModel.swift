//
//  FourthViewModel.swift
//  ShowMustGoOn
//
//  Created by 김지훈 on 11/18/24.
//

import UIKit

class FourthViewModel {
    // 섹션 데이터를 관리
    private(set) var categories: [MemoModel] = [MemoModel(id: UUID(), categoryTitle: "T1", itemTitle: ["도란", "오너", "페이커", "구마유시", "캐리아"], itemCompleted: [false, false, false, false, false])]
    
    // 데이터 변경 알림
    var onCategoriesUpdated: (() -> Void)?
    
    // 항목 추가
    func addItem(categoryId: UUID, itemTitle: String) {
        // 동일한 id를 가진 카테고리 찾기
        if let index = categories.firstIndex(where: { $0.id == categoryId }) {
            // 해당 카테고리에 아이템 추가
            categories[index].itemTitle.append(itemTitle)
        }
        
        // 데이터 갱신 후 UI 업데이트
        onCategoriesUpdated?()
    }
    
    // 항목 삭제
    func deleteItem(categoryId: UUID, itemTitle: String) {
        // 동일한 categoryTitle을 가진 카테고리들 중에서 항목 삭제
        if let categoryIndex = categories.firstIndex(where: { $0.id == categoryId }) {
            // 해당 카테고리에서 아이템 삭제
            if let itemIndex = categories[categoryIndex].itemTitle.firstIndex(of: itemTitle) {
                categories[categoryIndex].itemTitle.remove(at: itemIndex)
            }
        }
        
        // 데이터 갱신 후 UI 업데이트
        onCategoriesUpdated?()
    }
    
    // 카테고리 추가 메서드
    func addCategory(_ category: String) {
        guard !category.isEmpty else { return } // 빈 값 방지
        let newCategory = MemoModel(id: UUID(), categoryTitle: category, itemTitle: [], itemCompleted: [])
        categories.append(newCategory)
        onCategoriesUpdated?() // 데이터 변경 알림
    }
    
    // 카테고리 삭제 메서드
    func deleteCategory(_ id: UUID) {
        categories.removeAll { $0.id == id }
        onCategoriesUpdated?() // 데이터 변경 알림
    }
}

