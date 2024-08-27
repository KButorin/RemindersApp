//
//  ReminderServices.swift
//  RemindersApp
//
//  Created by ESSIP on 22.08.2024.
//

import Foundation
import CoreData
import UIKit

class ReminderServices {
    
    static var viewContext: NSManagedObjectContext {
        CoreDataprovider.shared.persistentContainer.viewContext
    }
    
    static func save() throws {
        try viewContext.save()
    }
    
    static func saveMyList(_ name: String, color: UIColor) throws {
        let myList = MyList(context: viewContext)
        myList.name = name
        myList.color = color
        try save()
    }
    
    static func deleteReminder(_ reminder: Reminder) throws {
        viewContext.delete(reminder)
        try save()
    }
    
    static func updateReminder(reminder: Reminder, editConfig: ReminderEditConfig) throws -> Bool {
        let reminderToUpdate = reminder
        reminderToUpdate.isCompleted = editConfig.isCompleted
        reminderToUpdate.title = editConfig.title
        reminderToUpdate.notes = editConfig.notes
        reminderToUpdate.reminderDate = editConfig.hasDate ? editConfig.reminderDate: nil
        reminderToUpdate.reminderTime = editConfig.hasTime ? editConfig.reminderTime : nil
        
        try save()
        return true 
    }
    
    static func saveReminderToMyList(myList: MyList, reminderTitle: String) throws {
        let reminder = Reminder(context: viewContext)
        reminder.title = reminderTitle
        myList.addToReminders(reminder)
        try save()
    }
    
    static func getRemindersByList(myList: MyList) -> NSFetchRequest<Reminder>{
        let request = Reminder.fetchRequest()
        request.sortDescriptors = []
        request.predicate = NSPredicate(format: "list = %@ AND isCompleted = false", myList)
        return request
    }
    
    
}
