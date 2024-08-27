//
//  PreviewData.swift
//  RemindersApp
//
//  Created by ESSIP on 22.08.2024.
//

import Foundation
import CoreData

class PreviewData {
    
    static var reminder: Reminder {
        let viewContext = CoreDataprovider.shared.persistentContainer.viewContext
        let request = Reminder.fetchRequest()
        return (try? viewContext.fetch(request).first) ?? Reminder(context: viewContext)
    }
    
    static var myList: MyList {
        let viewContext = CoreDataprovider.shared.persistentContainer.viewContext
        let request = MyList.fetchRequest()
        return (try? viewContext.fetch(request).first) ?? MyList()
    }
}
