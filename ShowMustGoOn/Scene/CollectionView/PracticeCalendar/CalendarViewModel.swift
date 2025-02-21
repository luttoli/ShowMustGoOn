//
//  CalendarViewModel.swift
//  ShowMustGoOn
//
//  Created by 김지훈 on 2/21/25.
//

import UIKit

class CalendarViewModel {
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
    
    // 해당 년월의 1일과 요일부터 말일 날짜까지
    func daysUpdate() {
        days.removeAll()
        let start = firstDayOfWeek() // 이번 달의 첫 날짜의 요일 가져오기
        let totalDays = endDate() // 이번 달의 마지막 날짜 가져오기
        
        // 빈 공간과 날짜를 한 번에 처리
        let totalCells = start + totalDays // 시작 요일 + 총 날짜 수
        for i in 0..<42 { // 6주 * 7일 = 42칸
            if i < start { // 첫 번째 주에 앞선 빈 공간 추가
                self.days.append("")
            } else if i < totalCells { // 날짜 추가
                self.days.append("\(i - start + 1)")
            } else { // 마지막 주 빈 공간 채우기
                self.days.append("")
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
