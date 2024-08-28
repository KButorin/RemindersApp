//
//  MyList+CoreDataClass.swift
//  RemindersApp
//
//  Created by ESSIP on 22.08.2024.
//
//

import Foundation
import CoreData

@objc(MyList)
public class MyList: NSManagedObject {
    var remindersArray: [Reminder] {
        reminders?.allObjects.compactMap{ ( $0 as! Reminder ) } ?? []
    }
}
