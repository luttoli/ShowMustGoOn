//
//  SectionViewModel.swift
//  ShowMustGoOn
//
//  Created by 김지훈 on 11/1/24.
//

import UIKit

class SectionTableViewModel {
    let frontNumbers = Array(2...9)
    let backNumbers = Array(1...9)
    
    lazy var multiplyData: [[SectionTableModel]] = {
        return frontNumbers.map { front in
            backNumbers.map { back in
                SectionTableModel(
                    frontNumber: front,
                    backNumber: back,
                    resultNumber: "\(front * back)",
                    showResult: false // 초기 상태: 결과 숨김
                )
            }
        }
    }()
    
    func toggleResult(at indexPath: IndexPath) {
        multiplyData[indexPath.section][indexPath.row].showResult.toggle()
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
