//
//  RxAddViewModel.swift
//  ShowMustGoOn
//
//  Created by 김지훈 on 1/17/25.
//

import UIKit

import RxCocoa
import RxSwift

class RxAddViewModel {
    let disposeBag = DisposeBag()
    
    var data = BehaviorRelay<[AddSection]>(value: [
        AddSection(id: UUID(), header: "T1", items: [
            CheckItem(checkItemId: UUID(), checkItemTitle: "도란", isChecked: false),
            CheckItem(checkItemId: UUID(), checkItemTitle: "오너", isChecked: true),
            CheckItem(checkItemId: UUID(), checkItemTitle: "페이커", isChecked: true),
            CheckItem(checkItemId: UUID(), checkItemTitle: "구마유시", isChecked: false),
            CheckItem(checkItemId: UUID(), checkItemTitle: "케리아", isChecked: false)
        ]),
    ])
    
    // 카테고리 추가
    func addCategory(categoryTitle: String) {
        guard !categoryTitle.isEmpty else { return }
        var datas = data.value
        let newCategory = AddSection(id: UUID(), header: categoryTitle, items: [])
        datas.append(newCategory)
        data.accept(datas)
    }
    
    // 카테고리 삭제
    func deletecategory(categoryId: UUID) {
        let datas = data.value
        let filteredData = datas.filter { $0.id != categoryId }
        data.accept(filteredData)
    }
    
    // 아이템 추가
    func addCheckItem(categoryId: UUID, checkItemTitle: String) {
        guard !checkItemTitle.isEmpty else { return }
        var datas = data.value
        if let categoryIndex = datas.firstIndex(where: { $0.id == categoryId }) {
            let newCheckItem = CheckItem(checkItemId: UUID(), checkItemTitle: checkItemTitle, isChecked: false)
            datas[categoryIndex].items.append(newCheckItem)
        }
        data.accept(datas)
    }
    
    // 아이템 삭제
    func deleteCheckItem(categoryId: UUID, checkItemId: UUID) {
        var datas = data.value
        if let categoryIndex = datas.firstIndex(where: { $0.id == categoryId }),
           let checkItemIndex = datas[categoryIndex].items.firstIndex(where: { $0.checkItemId == checkItemId }) {
            datas[categoryIndex].items.remove(at: checkItemIndex)
        }
        data.accept(datas)
    }
    
    // 아이템 체크 토글
    func checkItemToggle(categoryId: UUID, checkItemId: UUID) {
        var datas = data.value
        if let categoryIndex = datas.firstIndex(where: { $0.id == categoryId }), let checkItemIndex = datas[categoryIndex].items.firstIndex(where: { $0.checkItemId == checkItemId }) {
            datas[categoryIndex].items[checkItemIndex].isChecked.toggle()
        }
        data.accept(datas)
    }
}
