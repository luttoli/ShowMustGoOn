//
//  SectionViewModel.swift
//  ShowMustGoOn
//
//  Created by 김지훈 on 11/1/24.
//

import UIKit

class SectionViewModel {
    let frontNumbers = Array(2...9)
    let backNumbers = Array(1...9)
    
    var multiplyData: [[SectionModel]] {
        return frontNumbers.map { front in
            backNumbers.map { back in
                SectionModel(frontNumber: front, backNumber: back, resultNumber: "\(front * back)")
            }
        }
    }
}

// frontNumbers, backNumbers를 순회하며 이중 배열로 데이터 생성
// [[frontNumber * backNumber = resultNumber...], [frontNumber * backNumber = resultNumber...]]
// [
//     [
//         MultiplyModel(frontNumber: 2, backNumber: 1, resultNumber: "2"),
//         MultiplyModel(frontNumber: 2, backNumber: 2, resultNumber: "4"),
//         ...
//     ],
//
//     [
//         MultiplyModel(frontNumber: 3, backNumber: 1, resultNumber: "3"),
//         MultiplyModel(frontNumber: 3, backNumber: 2, resultNumber: "6"),
//         ...
//     ],
//     ...
// ]
