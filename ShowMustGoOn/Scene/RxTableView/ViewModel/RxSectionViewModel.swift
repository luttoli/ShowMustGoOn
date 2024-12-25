//
//  RxSectionViewModel.swift
//  ShowMustGoOn
//
//  Created by 김지훈 on 12/17/24.
//

import UIKit

import RxSwift
import RxCocoa

class RxSectionViewModel {
    let disposeBag = DisposeBag()
    
    let frontNumbers = Array(2...9)
    let backNumbers = Array(1...9)
    
    lazy var multiplyData: BehaviorRelay<[SectionModel]> = { // lazy - 처음 접근될 때 초기화되도록 | BehaviorRelay - 현재 [데이터]의 상태를 저장, 관찰
        let data = frontNumbers.flatMap { front in // 앞 숫자 데이터 생성 2 * (1...9)
            backNumbers.map { back in
                SectionModel( // 데이터를 해당 모델 타입으로 생성
                    frontNumber: front,
                    backNumber: back,
                    resultNumber: "\(front * back)",
                    showResult: false 
                )
            }
        }
        return BehaviorRelay(value: data)
    }()
    
    func toggleResult(at index: Int) {
        var currentData = multiplyData.value // multiplyData 현재 [데이터] 읽기
        guard currentData.indices.contains(index) else { return } // 전달받은 index가 배열 범위에 속하지 않으면 함수 종료
        currentData[index].showResult.toggle() // 결과 표시 상태 변경
        multiplyData.accept(currentData) // 업데이트된 데이터 반영
    }
}
