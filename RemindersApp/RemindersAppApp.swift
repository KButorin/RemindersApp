//
//  RemindersAppApp.swift
//  RemindersApp
//
//  Created by ESSIP on 22.08.2024.
//

import SwiftUI

@main
struct RemindersAppApp: App {
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environment(\.managedObjectContext, CoreDataprovider.shared.persistentContainer.viewContext)
        }
    }
}
