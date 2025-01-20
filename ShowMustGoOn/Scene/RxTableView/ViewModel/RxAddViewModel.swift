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
    
//    var categories = BehaviorRelay<[AddModel]>(value: [
//        AddModel(
//            id: UUID(),
//            categoryTitle: "T1",
//            checkItem: [
//                CheckItem(checkItemId: UUID(),
//                          checkItemTitle: "도란",
//                          isChecked: false
//                         ),
//                CheckItem(checkItemId: UUID(),
//                          checkItemTitle: "오너",
//                          isChecked: true
//                         ),
//                CheckItem(checkItemId: UUID(),
//                          checkItemTitle: "faker",
//                          isChecked: true
//                         ),
//                CheckItem(checkItemId: UUID(),
//                          checkItemTitle: "구마유시",
//                          isChecked: false
//                         ),
//                CheckItem(checkItemId: UUID(),
//                          checkItemTitle: "케리아",
//                          isChecked: false
//                         ),
//                ]
//            )
//        ]
//    )
    
    var data = BehaviorRelay<[AddSection]>(value: [
        AddSection(header: "T1", items: [
            CheckItem(checkItemId: UUID(), checkItemTitle: "도란", isChecked: false),
            CheckItem(checkItemId: UUID(), checkItemTitle: "오너", isChecked: true),
            CheckItem(checkItemId: UUID(), checkItemTitle: "faker", isChecked: true),
            CheckItem(checkItemId: UUID(), checkItemTitle: "구마유시", isChecked: false),
            CheckItem(checkItemId: UUID(), checkItemTitle: "케리아", isChecked: false)
        ])
    ])
}
