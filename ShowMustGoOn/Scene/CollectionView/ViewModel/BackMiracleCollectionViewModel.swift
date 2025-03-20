//
//  BackMiracleCollectionViewModel.swift
//  ShowMustGoOn
//
//  Created by 김지훈 on 2/28/25.
//

import UIKit

class BackMiracleCollectionViewModel {
    let backMiracles: [BackMiracleCollectionModel] = [
        BackMiracleCollectionModel(
            title: "코딩해서 깃헙에 올리기",
            startDate: Date()
        ),
        BackMiracleCollectionModel(
            title: "너의 목소리가 들려",
            startDate: Date()
        ),
        BackMiracleCollectionModel(
            title: "나는 솔로",
            startDate: Date()
        )
    ]

    //
    var calendar: Calendar = {
        var calendar = Calendar(identifier: .gregorian)
        calendar.locale = Locale(identifier: "ko_KR") // 한국 로케일
        calendar.timeZone = TimeZone(identifier: "Asia/Seoul")! // 한국 시간대
        return calendar
    }()
    
    // DateFormatter 설정
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "YY년\nMM월"
        formatter.locale = Locale(identifier: "ko_KR") // 한국어 표시
        formatter.timeZone = TimeZone(identifier: "Asia/Seoul")! // 한국 시간대
        return formatter
    }()
    
    // 현재 날짜 0000-00-00 00:00:00
    var calendarDate = Date()
    
    // 일 데이터 ["", "", "1"...]
    var days = [String]()
    
    // 뷰에서 구독할 수 있도록 프로퍼티 추가
    var yearLabelText: String {
        return dateFormatter.string(from: calendarDate)
    }
    
    // 날짜 업데이트 메서드
    func updateYear(to date: Date) {
        calendarDate = date
        
    }
    
    // 전체 챌린지 중 완료된 개수 계산
    var doneCount: Int {
        backMiracles.reduce(0) { $0 + $1.doneCount }
    }
}
