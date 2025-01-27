//
//  BasicCollectionViewModel.swift
//  ShowMustGoOn
//
//  Created by 김지훈 on 1/27/25.
//

import UIKit

class BasicCollectionViewModel {
    let number: [BasicCollectionModel] = (1...15).map {
        BasicCollectionModel(number: "\($0)")
    }
}
