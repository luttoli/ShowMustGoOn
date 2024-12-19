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
