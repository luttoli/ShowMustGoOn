//
//  ThirdViewModel.swift
//  ShowMustGoOn
//
//  Created by 김지훈 on 11/6/24.
//

import UIKit

class ThirdViewModel {
    var eSportNews: [ESportsModel] = [
        ESportsModel(mainImage: [
            UIImage(named: "proveit"),
            UIImage(named: "GENGDown"),
            UIImage(named: "BLGDown"),
        ], subNews: [
            SubNews(subImage: UIImage(named: "1"), subTitle: "끝나지 않은 명장 김정균의 꿈, T1 복귀 첫 해 애제자 ‘페이커’와 롤드컵 첫 감독 우승"),
            SubNews(subImage: UIImage(named: "2"), subTitle: "T1 'V5' 이끈 '페이커' 이상혁의 클러치 플레이"),
            SubNews(subImage: UIImage(named: "3"), subTitle: "“이 멤버로 많은 기록 만들었다” T1과 늘 함께 하고픈 ‘구마유시’의 낭만 이야기"),
            SubNews(subImage: UIImage(named: "4"), subTitle: "‘제오페구케’ 또 하나의 왕조…T1, 팬들 위해 ’엑소더스’ 막고 ‘왕조’ 사수 천명"),
            SubNews(subImage: UIImage(named: "5"), subTitle: "“페이커, 그는 GOAT”…美·中해설도 감탄한 우승 순간"),
        ])
    ]
}
