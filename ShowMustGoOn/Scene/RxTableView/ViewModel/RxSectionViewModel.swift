//
//  RxSectionViewModel.swift
//  ShowMustGoOn
//
//  Created by 김지훈 on 12/17/24.
//

import UIKit

import RxSwift

class RxSectionViewModel {
    let disposeBag = DisposeBag()
    
    let frontNumbers = Array(2...9)
    let backNumbers = Array(1...9)
    
    lazy var multiplyData: Observable<[SectionModel]> = {
        let data = frontNumbers.flatMap { front in
            backNumbers.map { back in
                SectionModel(
                    frontNumber: front,
                    backNumber: back,
                    resultNumber: "?"
                )
            }
        }
        return Observable.just(data)
    }()
}
