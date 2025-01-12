//
//  MyList+CoreDataProperties.swift
//  RemindersApp
//
//  Created by ESSIP on 22.08.2024.
//
//

import Foundation
import CoreData
import UIKit

extension MyList {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MyList> {
        return NSFetchRequest<MyList>(entityName: "MyList")
    }

    @NSManaged public var name: String
    @NSManaged public var color: UIColor
    @NSManaged public var reminders: NSSet?


}

extension MyList : Identifiable {
    @objc(addRemindersObject:)
    @NSManaged public func addToReminders(_ value: Reminder)
    
    @objc(removeRemindersObject:)
    @NSManaged public func removeFromReminders(_ value: Reminder)
    
    @objc(addReminders:)
    @NSManaged public func addToReminders(_ values: NSSet)
    
    @objc(removeReminders:)
    @NSManaged public func removeFromReminders(_ values: NSSet)
}
