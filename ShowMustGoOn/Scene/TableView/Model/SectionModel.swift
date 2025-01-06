//
//  SectionModel.swift
//  ShowMustGoOn
//
//  Created by 김지훈 on 11/1/24.
//

import UIKit

struct SectionModel {
    let frontNumber: Int
    let backNumber: Int
    let resultNumber: String
    var showResult: Bool
}

// RxDataSources에서 섹션을 나타낼 모델을 정의
import RxDataSources

struct MultiplySection {
    var header: String // 섹션 헤더 제목
    var items: [Item]  // 섹션에 포함된 데이터
    
    init(header: String, items: [Item]) {
        self.header = header
        self.items = items
    }
}

extension MultiplySection: SectionModelType {
    typealias Item = SectionModel
    
    init(original: MultiplySection, items: [SectionModel]) {
        self = original
        self.items = items
    }
}
