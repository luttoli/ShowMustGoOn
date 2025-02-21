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
    
    // 2024년 1월 ~ 2026년 12월까지의 월을 저장할 배열
    var months = [Date]()
    
    // 현재 보여지는 월
    var currentIndex: Int = 0
    
    // 각 월별 일자 데이터를 저장하는 딕셔너리
    var daysByMonths : [Date: [String]] = [:]

    // 2024년 1월부터 2026년 12월까지의 월을 생성하는 함수
//    func generateMonths() {
//        let dateComponents = DateComponents(year: 2024, month: 1)
//        guard let startDate = calendar.date(from: dateComponents) else { return }
//
//        for i in 0..<(3 * 12) { // 3년 * 12개월
//            if let monthDate = calendar.date(byAdding: .month, value: i, to: startDate) {
//                months.append(monthDate)
//                generateDays(for: monthDate)
//            }
//        }
//
//        // 오늘 날짜가 포함된 월을 찾아서 currentIndex 설정
//        if let todayIndex = months.firstIndex(where: { calendar.isDate(Date(), equalTo: $0, toGranularity: .month) }) {
//            currentIndex = todayIndex
//        }
//    }
    // 비교
    func generateMonths() {
        let calendar = Calendar.current
        
        // 시작일: 2024년 1월 1일
        let startDateComponents = DateComponents(year: 2024, month: 1)
        guard let startDate = calendar.date(from: startDateComponents) else { return }
        
        // 종료일: 2026년 12월 31일
        let endDateComponents = DateComponents(year: 2026, month: 12, day: 31)
        guard let endDate = calendar.date(from: endDateComponents) else { return }
        
        var currentDate = startDate
        
        while currentDate <= endDate {
            months.append(currentDate) // 월 추가
            generateDays(for: currentDate) // 해당 월의 일 추가
            currentDate = calendar.date(byAdding: .month, value: 1, to: currentDate) ?? endDate // 다음 월로 이동
        }

        // 오늘 날짜가 포함된 월을 찾아서 currentIndex 설정
        if let todayIndex = months.firstIndex(where: { calendar.isDate(Date(), equalTo: $0, toGranularity: .month) }) {
            currentIndex = todayIndex
        }
    }
    
    // 특정 월의 일자를 가져와서 저장하는 함수
    func generateDays(for date: Date) {
        let firstDayOfWeeks = self.firstDayOfWeeks(for: date) // 1일의 요일 가져오기
        let totalDays = self.endDates(for: date) // 말일 가져오기
        
        var days = [String]()
        let totalCells = firstDayOfWeeks + totalDays // 빈칸 + 날짜
        
        for i in 0..<42 { // 6주 * 7일 = 42칸
            if i < firstDayOfWeeks { // 첫 주 빈칸
                days.append("")
            } else if i < totalCells { // 날짜 채우기
                days.append("\(i - firstDayOfWeeks + 1)")
            } else { // 마지막 주 빈칸
                days.append("")
            }
        }
        
        // 해당 월의 날짜 배열을 딕셔너리에 저장
        daysByMonths[date] = days
    }

    // 특정 월의 1일이 무슨 요일인지 계산하는 함수
    func firstDayOfWeeks(for date: Date) -> Int {
        let components = calendar.dateComponents([.year, .month], from: date)
        guard let firstDay = calendar.date(from: components) else { return 0 }
        return calendar.component(.weekday, from: firstDay) - 1
    }

    // 특정 월의 말일을 구하는 함수
    func endDates(for date: Date) -> Int {
        return calendar.range(of: .day, in: .month, for: date)?.count ?? 0
    }
}
