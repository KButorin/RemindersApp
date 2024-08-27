//
//  Date+Extensions.swift
//  RemindersApp
//
//  Created by ESSIP on 23.08.2024.
//

import Foundation

extension Date {
    
    var isToday: Bool {
        let calendar = Calendar.current
        return calendar.isDateInToday(self)
    }
    
    var isTomorrow: Bool {
        let calendar = Calendar.current
        return calendar.isDateInTomorrow(self)
    }
    
    var dateComponents: DateComponents {
        Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: self)
    }
    
}
