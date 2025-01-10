//
//  RxMixViewModel.swift
//  ShowMustGoOn
//
//  Created by 김지훈 on 1/7/25.
//

import UIKit

import RxCocoa
import RxSwift

class RxMixViewModel {
    let tableViewData = BehaviorRelay<[MixModel]>(value: [
        .init(mainImage: [
            UIImage(named: "proveit"),
            UIImage(named: "GENGDown"),
            UIImage(named: "BLGDown"),
        ], subNews: [
            SubNews(subImage: UIImage(named: "oner"), subTitle: "[오피셜] T1, '구마유시' 이민형과 1년 재계약", url: "https://m.sports.naver.com/esports/article/442/0000177500?sid3=79b"),
            SubNews(subImage: UIImage(named: "gumayusi"), subTitle: "[오피셜] T1, 정글러 '오너' 문현준과 2년 재계약", url: "https://m.sports.naver.com/esports/article/442/0000177447?sid3=79b"),
            SubNews(subImage: UIImage(named: "keria"), subTitle: "[오피셜] T1, 서포터 '케리아' 류민석과 2년 재계약", url: "https://m.sports.naver.com/esports/article/442/0000177387?sid3=79b"),
            SubNews(subImage: UIImage(named: "1"), subTitle: "끝나지 않은 명장 김정균의 꿈, T1 복귀 첫 해 애제자 ‘페이커’와 롤드컵 첫 감독 우승", url: "https://m.sports.naver.com/esports/article/109/0005190223?sid3=79b"),
            SubNews(subImage: UIImage(named: "2"), subTitle: "T1 'V5' 이끈 '페이커' 이상혁의 클러치 플레이", url: "https://m.sports.naver.com/esports/article/347/0000183496?sid3=79b"),
            SubNews(subImage: UIImage(named: "3"), subTitle: "“이 멤버로 많은 기록 만들었다” T1과 늘 함께 하고픈 ‘구마유시’의 낭만 이야기", url: "https://m.sports.naver.com/esports/article/468/0001105834?sid3=79b"),
            SubNews(subImage: UIImage(named: "4"), subTitle: "‘제오페구케’ 또 하나의 왕조…T1, 팬들 위해 ’엑소더스’ 막고 ‘왕조’ 사수 천명", url: "https://m.sports.naver.com/esports/article/109/0005189282?sid3=79b"),
            SubNews(subImage: UIImage(named: "5"), subTitle: "“페이커, 그는 GOAT”…美·中해설도 감탄한 우승 순간", url: "https://m.sports.naver.com/esports/article/005/0001735927?sid3=79b"),
        ])
    ])
}
