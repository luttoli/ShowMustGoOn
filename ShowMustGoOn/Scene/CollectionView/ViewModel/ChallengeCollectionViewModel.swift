//
//  ChallengeCollectionViewModel.swift
//  ShowMustGoOn
//
//  Created by 김지훈 on 2/28/25.
//

import UIKit

class ChallengeCollectionViewModel {
    private(set) var challenges: [ChallengeCollectionModel] = [
        ChallengeCollectionModel(
            id: UUID(),
            title: "코딩해서 깃헙에 올리기",
            date: Date(),
            month: [
                Month(date: Date(), isChecked: true),
                Month(date: Date(), isChecked: false),
                Month(date: Date(), isChecked: false),
                Month(date: Date(), isChecked: false),
                Month(date: Date(), isChecked: false),
                Month(date: Date(), isChecked: true),
                Month(date: Date(), isChecked: false),
                Month(date: Date(), isChecked: false),
                Month(date: Date(), isChecked: false),
                Month(date: Date(), isChecked: false),
                Month(date: Date(), isChecked: false),
                Month(date: Date(), isChecked: true),
                Month(date: Date(), isChecked: false),
                Month(date: Date(), isChecked: false),
                Month(date: Date(), isChecked: false),
                Month(date: Date(), isChecked: true),
                Month(date: Date(), isChecked: false),
                Month(date: Date(), isChecked: false),
                Month(date: Date(), isChecked: true),
                Month(date: Date(), isChecked: false),
                Month(date: Date(), isChecked: false),
                Month(date: Date(), isChecked: false),
                Month(date: Date(), isChecked: false),
                Month(date: Date(), isChecked: false),
                Month(date: Date(), isChecked: true),
                Month(date: Date(), isChecked: false),
                Month(date: Date(), isChecked: false),
                Month(date: Date(), isChecked: true),
            ]
        )
    ]
    
    
}
