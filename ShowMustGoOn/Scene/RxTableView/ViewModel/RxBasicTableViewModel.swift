//
//  RxBasicViewModel.swift
//  ShowMustGoOn
//
//  Created by 김지훈 on 12/12/24.
//

import UIKit

import RxSwift

//class RxBasicViewModel {
//    let numbers = Observable.of(["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14"])
//    let titles = Observable.of(["가", "나", "다", "라", "마", "바", "사", "아", "자", "차", "카", "타", "파", "하"])
//    
//    lazy var data: Observable<[BasicModel]> = {
//        Observable
//            .combineLatest(numbers, titles)
//            .map { numbers, titles in
//                zip(numbers,titles).map { BasicModel(number: $0, title: $1)}
//            }
//    }()
//}

// init 초기화 사용
class RxBasicTableViewModel {
    let numbers: Observable<[String]>
    let titles: Observable<[String]>
    let data: Observable<[BasicTableModel]>
    
    init() {
        self.numbers = Observable.of(["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14"])
        self.titles = Observable.of(["가", "나", "다", "라", "마", "바", "사", "아", "자", "차", "카", "타", "파", "하"])
        
        self.data = Observable
            .combineLatest(numbers, titles)
            .map { numbers, titles in
                zip(numbers, titles).map { BasicTableModel(number: $0, title: $1) }
            }
    }
}
