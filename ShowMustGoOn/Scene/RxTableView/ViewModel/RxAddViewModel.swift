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
    
    // 카테고리 삭제
    
    // 아이템 추가
    
    // 아이템 삭제
    
    // 아이템 체크 토글
}
