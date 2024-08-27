//
//  ReminderListView.swift
//  RemindersApp
//
//  Created by ESSIP on 23.08.2024.
//

import SwiftUI

struct ReminderListView: View {
    
    let reminders: FetchedResults<Reminder>
    @State private var selectedReminder: Reminder?
    @State private var showReminderDetail: Bool = false 
    
    private func reminderCheckedChange(reminder: Reminder, isCompleted: Bool) {
        var editConfig = ReminderEditConfig(reminder: reminder)
        editConfig.isCompleted = isCompleted
        
        do {
            let _ = try ReminderServices.updateReminder(reminder: reminder, editConfig: editConfig)
        } catch {
            print(error)
        }
    }
    
    private func isReminderSelected(_ reminder: Reminder) -> Bool {
        selectedReminder?.objectID == reminder.objectID
    }
    
    private func deleteReminder(_ indexSet: IndexSet){
        indexSet.forEach { index in
            let reminder = reminders[index]
            do {
                try ReminderServices.deleteReminder(reminder)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    var body: some View {
        VStack {
            List {
                ForEach(reminders) { reminder in
                    ReminderCellView(reminder: reminder, isSelected: isReminderSelected(reminder)) { event in
                        switch event {
                        case .onSelect(let reminder):
                            selectedReminder = reminder
                            print("onSelect")
                        case .onCheckedChange(let reminder, let isCompleted):
                            reminderCheckedChange(reminder: reminder, isCompleted: isCompleted)
                        case .onInfo:
                            showReminderDetail = true
                        }
                    }
                }.onDelete(perform: deleteReminder)
            }
        }.sheet(isPresented: $showReminderDetail) {
            ReminderDetailView(reminder: Binding($selectedReminder)!)
        }
    }
}



struct ReminderListView_Previews: PreviewProvider {
    
    struct ReminderListViewContainer: View {
        
        @FetchRequest(sortDescriptors: [])
        private var reminderResults: FetchedResults<Reminder>
        
        var body: some View {
            ReminderListView(reminders: reminderResults)
        }
    }
    
    static var previews: some View {
        ReminderListViewContainer()
            .environment(\.managedObjectContext, CoreDataprovider.shared.persistentContainer.viewContext)
    }
    
    
 }
