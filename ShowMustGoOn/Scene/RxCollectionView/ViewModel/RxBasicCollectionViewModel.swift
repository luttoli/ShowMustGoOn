//
//  RxBasicCollectionViewModel.swift
//  ShowMustGoOn
//
//  Created by 김지훈 on 3/23/25.
//

import UIKit

import RxSwift

class RxBasicCollectionViewModel {
    let numbers: Observable<[String]>
    let data: Observable<[BasicCollectionModel]>
    
    init() {
        self.numbers = Observable.of(["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15"])
        
        self.data = numbers
            .map { numbers in
                numbers.map { BasicCollectionModel(number: [$0]) }
            }
    }
}
