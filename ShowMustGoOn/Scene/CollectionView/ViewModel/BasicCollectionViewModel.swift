//
//  BasicCollectionViewModel.swift
//  ShowMustGoOn
//
//  Created by 김지훈 on 1/25/25.
//

import UIKit

class BasicCollectionViewModel {
    var firstKey: [BasicCollectionModel] = {
        let first = ["ㅂ", "ㅈ", "ㄷ", "ㄱ", "ㅅ", "ㅛ", "ㅕ", "ㅑ", "ㅐ", "ㅔ"]
        
        return first.map {
            BasicCollectionModel(textKey: $0)
        }
    }()
    
    var secondKey: [BasicCollectionModel] = {
        let second = ["ㅁ", "ㄴ", "ㅇ", "ㄹ", "ㅎ", "ㅗ", "ㅓ", "ㅏ", "ㅣ"]
        
        return second.map {
            BasicCollectionModel(textKey: $0)
        }
    }()
    
    var thirdKey: [BasicCollectionModel] = {
        let third = ["ㅋ", "ㅌ", "ㅊ", "ㅍ", "ㅠ", "ㅜ", "ㅡ"]
        
        return third.map {
            BasicCollectionModel(textKey: $0)
        }
    }()
    
    var keys: [[String]] = [
        ["ㅂ", "ㅈ", "ㄷ", "ㄱ", "ㅅ", "ㅛ", "ㅕ", "ㅑ", "ㅐ", "ㅔ"],
        ["ㅁ", "ㄴ", "ㅇ", "ㄹ", "ㅎ", "ㅗ", "ㅓ", "ㅏ", "ㅣ"],
        ["ㅋ", "ㅌ", "ㅊ", "ㅍ", "ㅠ", "ㅜ", "ㅡ"]
    ]
}
