//
//  KeyboardCollectionViewModel.swift
//  ShowMustGoOn
//
//  Created by 김지훈 on 1/25/25.
//

import UIKit

class KeyboardCollectionViewModel {
    var keys: [[KeyboardCollectionModel]] = [
        [ "ㅂ", "ㅈ", "ㄷ", "ㄱ", "ㅅ", "ㅛ", "ㅕ", "ㅑ", "ㅐ", "ㅔ" ].map { KeyboardCollectionModel(textKey: $0) },
        [ "ㅁ", "ㄴ", "ㅇ", "ㄹ", "ㅎ", "ㅗ", "ㅓ", "ㅏ", "ㅣ" ].map { KeyboardCollectionModel(textKey: $0) },
        [ "^", "ㅋ", "ㅌ", "ㅊ", "ㅍ", "ㅠ", "ㅜ", "ㅡ", "⌫" ].map { KeyboardCollectionModel(textKey: $0) },
        [ "스페이스" ].map { KeyboardCollectionModel(textKey: $0) }
    ]
}
