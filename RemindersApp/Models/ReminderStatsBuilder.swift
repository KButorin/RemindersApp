//
//  ReminderStatsBuilder.swift
//  RemindersApp
//
//  Created by ESSIP on 27.08.2024.
//

import Foundation
import SwiftUI

struct ReminderStatsValues {
    var todayCount: Int = 0
    var scheduleCount: Int = 0
    var allCount: Int = 0
    var completedCount: Int = 0
}

struct ReminderStatsBuilder {
    func build(myListResults: FetchedResults<MyList>) -> ReminderStatsValues {
        let remindersArray = myListResults.map {
            $0.remindersArray
        }.reduce([], +)
        
        let todaysCount = calculateTodaysCount(reminders: remindersArray)
        let scheduledCount = calculateScheduleCount(reminders: remindersArray)
        let completedCount = calculateCompletedCount(reminders: remindersArray)
        let allCount = calculateAllCount(reminders: remindersArray)
        
        return ReminderStatsValues(todayCount: todaysCount, scheduleCount: scheduledCount, allCount: allCount, completedCount: completedCount)
    }
    
    private func calculateScheduleCount(reminders: [Reminder]) -> Int {
        return reminders.reduce(0){ result, reminder in
            return ((reminder.reminderDate != nil || reminder.reminderTime != nil) && !reminder.isCompleted) ? result+1 : result
        }
    }
    
    private func calculateTodaysCount(reminders: [Reminder]) -> Int {
        return reminders.reduce(0){ result, reminder in
            let isToday = reminder.reminderDate?.isToday ?? false
            return isToday ? result+1 : result
        }
    }
    
    private func calculateCompletedCount(reminders: [Reminder]) -> Int {
        return reminders.reduce(0){ result, reminder in
            return reminder.isCompleted ? +1 : result
        }
    }
    
    private func calculateAllCount(reminders: [Reminder]) -> Int {
        return reminders.reduce(0) { result, reminder in
            return reminder.isCompleted ? result+1 : result
        }
    }
    
}
