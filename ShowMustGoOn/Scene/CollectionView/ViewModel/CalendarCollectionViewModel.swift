//
//  CalendarCollectionViewModel.swift
//  ShowMustGoOn
//
//  Created by 김지훈 on 2/9/25.
//

import UIKit

class CalendarCollectionViewModel {
    // 캘린더 인스턴스
    var calendar: Calendar = {
        var calendar = Calendar(identifier: .gregorian)
        calendar.locale = Locale(identifier: "ko_KR") // 한국 로케일
        calendar.timeZone = TimeZone(identifier: "Asia/Seoul")! // 한국 시간대
        return calendar
    }()
    
    // DateFormatter 설정
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy년 MM월"
        formatter.locale = Locale(identifier: "ko_KR") // 한국어 표시
        formatter.timeZone = TimeZone(identifier: "Asia/Seoul")! // 한국 시간대
        return formatter
    }()
    
    // 현재 날짜
    var calendarDate = Date()

    // 일 데이터
    var days = [String]()
    
    // 월
    var months = [Date]()
    
    // 뷰에서 구독할 수 있도록 프로퍼티 추가
    var yearLabelText: String {
        return dateFormatter.string(from: calendarDate)
    }
    
    // 날짜 업데이트 메서드
    func updateYear(to date: Date) {
        calendarDate = date
        daysUpdate()
    }
    
    // 해당 월의 1일이 무슨 요일인지 계산하는 함수
    func firstDayOfWeek() -> Int {
        // 현재 calendarDate의 연도와 월을 가져와서 1일로 설정
        let components = calendar.dateComponents([.year, .month], from: calendarDate)
        guard let firstDay = calendar.date(from: components) else { return 0 }
        
        // 1일의 요일 반환 (0 = 일요일, 6 = 토요일)
        return calendar.component(.weekday, from: firstDay) - 1
    }
    
    // 말일
    func endDate() -> Int {
        return calendar.range(of: .day, in: .month, for: self.calendarDate)?.count ?? 0
    }
    
    // 오늘 요일 계산 : 0부터니까 -1해서 0이면 일요일 6이면 토요일이 반환되게
    func dayOfTheWeek() -> Int {
        return calendar.component(.weekday, from: calendarDate) - 1
    }
    
    // 오늘 날짜 가져오기
    var todayString: String {
        let today = calendar.dateComponents([.year, .month, .day], from: calendarDate) // 오늘 날짜 (1~31)
        return "\(today)"
    }
    
    //
    func daysUpdate() {
        days.removeAll()
        let start = firstDayOfWeek()
        let totalDays = endDate() // 이번 달의 마지막 날짜 가져오기
        
        for i in 0..<(start + totalDays) {
            if i < start {
                self.days.append("") // 빈 공간 추가 (1일 앞에 여백 추가)
            } else {
                self.days.append("\(i - start + 1)")
            }
        }
    }
    
    //
    func monthsUpdate() {
        for i in -12...12 { // 이전 12개월 ~ 이후 12개월
            if let monthDate = calendar.date(byAdding: .month, value: i, to: calendarDate) {
                months.append(monthDate)
            }
        }
    }
    
    // 오늘 날짜
    var todayNumber: String? {
        let today = calendar.dateComponents([.year, .month, .day], from: Date()) // 현재 날짜
        let currentMonth = calendar.dateComponents([.year, .month], from: calendarDate) // 현재 보고 있는 월
        
        // 현재 보고 있는 달과 오늘의 달이 같다면 오늘 날짜 반환
        if today.year == currentMonth.year, today.month == currentMonth.month {
            return "\(today.day!)"
        }
        return nil
    }
}
