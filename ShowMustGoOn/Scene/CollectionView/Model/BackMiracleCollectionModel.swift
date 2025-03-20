//
//  BackMiracleCollectionModel.swift
//  ShowMustGoOn
//
//  Created by 김지훈 on 2/27/25.
//

import UIKit

//struct BackMiracleCollectionModel {
//    let id: UUID
//    let title: String
//    var date: Date
//    var backDays: [BackDays]
//    
//    // 완료 카운트
//    var doneCount: Int {
//        backDays.filter { $0.isChecked }.count
//    }
//}
//
//struct BackDays {
//    var date: Date
//    var isChecked: Bool
//}

struct BackMiracleCollectionModel {
    let id: UUID
    let title: String
    var startDate: Date
    var backDays: [Date: Bool]  // Dictionary로 변경
    
    // 완료 카운트
    var doneCount: Int {
        backDays.values.filter { $0 }.count
    }
    
    // 100일 동안의 챌린지 데이터를 자동 생성하는 초기화
    init(title: String, startDate: Date = Date()) {
        self.id = UUID()
        self.title = title
        self.startDate = startDate
        self.backDays = Self.generate100Days(from: startDate)
    }
    
    // 100일 동안의 데이터를 미리 생성
    private static func generate100Days(from startDate: Date) -> [Date: Bool] {
        var days = [Date: Bool]()
        for i in 0..<100 {
            if let date = Calendar.current.date(byAdding: .day, value: i, to: startDate) {
                days[date] = false  // 처음에는 다 false(미완료)
            }
        }
        return days
    }
    
    // 특정 날짜 완료 처리 (ex: 버튼 클릭 시)
    mutating func markAsDone(for date: Date) {
        if backDays.keys.contains(date) {
            backDays[date] = true
        }
    }
}
