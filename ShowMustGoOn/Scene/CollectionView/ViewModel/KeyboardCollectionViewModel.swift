//
//  KeyboardCollectionViewModel.swift
//  ShowMustGoOn
//
//  Created by 김지훈 on 1/25/25.
//

import UIKit

class KeyboardCollectionViewModel {
//    var firstKey: [KeyboardCollectionModel] = {
//        let first = ["ㅂ", "ㅈ", "ㄷ", "ㄱ", "ㅅ", "ㅛ", "ㅕ", "ㅑ", "ㅐ", "ㅔ"]
//        
//        return first.map {
//            KeyboardCollectionModel(textKey: $0)
//        }
//    }()
//    
//    var secondKey: [KeyboardCollectionModel] = {
//        let second = ["ㅁ", "ㄴ", "ㅇ", "ㄹ", "ㅎ", "ㅗ", "ㅓ", "ㅏ", "ㅣ"]
//        
//        return second.map {
//            KeyboardCollectionModel(textKey: $0)
//        }
//    }()
//    
//    var thirdKey: [KeyboardCollectionModel] = {
//        let third = ["ㅋ", "ㅌ", "ㅊ", "ㅍ", "ㅠ", "ㅜ", "ㅡ"]
//        
//        return third.map {
//            KeyboardCollectionModel(textKey: $0)
//        }
//    }()
    
    var keys: [[String]] = [
        ["ㅂ", "ㅈ", "ㄷ", "ㄱ", "ㅅ", "ㅛ", "ㅕ", "ㅑ", "ㅐ", "ㅔ"],
        ["ㅁ", "ㄴ", "ㅇ", "ㄹ", "ㅎ", "ㅗ", "ㅓ", "ㅏ", "ㅣ"],
        ["^", "ㅋ", "ㅌ", "ㅊ", "ㅍ", "ㅠ", "ㅜ", "ㅡ", "⌫"],
        ["스페이스"]
    ]
    
    var shiftKey: [[String]] = [
        ["ㅃ", "ㅉ", "ㄸ", "ㄲ", "ㅆ", "ㅛ", "ㅕ", "ㅑ", "ㅒ", "ㅖ"],
    ]
}
