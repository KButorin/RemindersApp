//
//  MyListDetailView.swift
//  RemindersApp
//
//  Created by ESSIP on 23.08.2024.
//

import SwiftUI

struct MyListDetailView: View {
    
    let myList: MyList
    @State private var openAddReminder: Bool = false
    @State private var title: String = ""
    private var isFormValid: Bool {
        !title.isEmpty
    }
    @FetchRequest(sortDescriptors: [])
    private var reminderResults: FetchedResults<Reminder>
    
    init(myList: MyList) {
        self.myList = myList
        _reminderResults = FetchRequest(fetchRequest: ReminderServices.getRemindersByList(myList: myList))
    }    
    var body: some View {
        VStack {
            //Display list of reminders
            
            ReminderListView(reminders: reminderResults)
            
            HStack {
                Image(systemName: "plus.circle.fill")
                Button("New Reminder"){
                    openAddReminder = true
                }
            }.foregroundStyle(.blue)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
        }.alert("New Reminder", isPresented: $openAddReminder) {
            TextField("", text: $title)
            Button("Cancel", role: .cancel) { }
            Button("Done") {
                if isFormValid {
                    //Save the reminder to myList 
                    do {
                        try ReminderServices.saveReminderToMyList(myList: myList, reminderTitle: title)
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            }
        }
    }
}

#Preview {
    MyListDetailView(myList: PreviewData.myList)
}
