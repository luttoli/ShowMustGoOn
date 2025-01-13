//
//  MixModel.swift
//  ShowMustGoOn
//
//  Created by 김지훈 on 11/6/24.
//

import UIKit

struct MixModel {
    let mainImage: [UIImage?]
    let subNews: [SubNews]
}

struct SubNews {
    let subImage: UIImage?
    let subTitle: String
    let url: String?
}

import RxDataSources

struct MixSection {
    var items: [MixModel]
    
    init(items: [MixModel]) {
        self.items = items
    }
}

extension MixSection: SectionModelType {
    typealias Item = MixModel
    
    init(original: MixSection, items: [Item]) {
        self = original
        self.items = items
    }
}
