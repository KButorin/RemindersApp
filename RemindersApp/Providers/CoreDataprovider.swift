//
//  CoreDataprovider.swift
//  RemindersApp
//
//  Created by ESSIP on 22.08.2024.
//

import Foundation
import CoreData

class CoreDataprovider {
    static let shared = CoreDataprovider()
    let persistentContainer: NSPersistentContainer
    
    private init(){
        
        //register providers
        
        ValueTransformer.setValueTransformer(UIColorTransformer(), forName: NSValueTransformerName("UIColorTransformer"))
        
        persistentContainer = NSPersistentContainer(name: "RemindersModel")
        persistentContainer.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Error initializing RemindersModel: \(error)")
            }
        }
    }
    
}
