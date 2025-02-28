//
//  ChallengeCollectionModel.swift
//  ShowMustGoOn
//
//  Created by 김지훈 on 2/27/25.
//

import UIKit

struct ChallengeCollectionModel {
    let id: UUID
    let title: String
    var date: Date
    var month: [Month]
    
}

struct Month {
    var date: Date
    var isChecked: Bool
}
