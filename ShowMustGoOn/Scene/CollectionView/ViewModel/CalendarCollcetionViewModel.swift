//
//  CalendarCollcetionViewModel.swift
//  ShowMustGoOn
//
//  Created by 김지훈 on 2/9/25.
//

import UIKit

class CalendarCollcetionViewModel {
    //
    var calendar = Calendar.current
    
    //
    var dateformatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy년 MM월"
        return formatter
    }
    
    //
    var calendarDate = Date()
    
     
}
