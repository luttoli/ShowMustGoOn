//
//  CalendarCollcetionViewModel.swift
//  ShowMustGoOn
//
//  Created by 김지훈 on 2/9/25.
//

import UIKit

class CalendarCollcetionViewModel {
    // 캘린더 인스턴스
    var calendar = Calendar.current
    
    // DateFormatter 설정
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy년 MM월"
        return formatter
    }()
    
    // 현재 날짜
    private(set) var calendarDate = Date()
    
    // 뷰에서 구독할 수 있도록 프로퍼티 추가
    var yearLabelText: String {
        return dateFormatter.string(from: calendarDate)
    }
    
    // 날짜 업데이트 메서드
    func updateYear(to date: Date) {
        calendarDate = date
    }
}
