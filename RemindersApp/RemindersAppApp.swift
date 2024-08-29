//
//  RemindersAppApp.swift
//  RemindersApp
//
//  Created by ESSIP on 22.08.2024.
//

import SwiftUI
import UserNotifications

@main
struct RemindersAppApp: App {
    
    init(){
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if granted {
                //notification is granted 
            } else {
                //Display message to the user
            }
        }
    }
    
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environment(\.managedObjectContext, CoreDataprovider.shared.persistentContainer.viewContext)
        }
    }
}
