//
//  BackMiracleCollectionModel.swift
//  ShowMustGoOn
//
//  Created by 김지훈 on 2/27/25.
//

import UIKit

struct BackMiracleCollectionModel {
    let id: UUID
    let title: String
    var date: Date
    var backDays: [BackDays]
    
    // 완료 카운트
    var doneCount: Int {
        backDays.filter { $0.isChecked }.count
    }
}

struct BackDays {
    var date: Date
    var isChecked: Bool
}
