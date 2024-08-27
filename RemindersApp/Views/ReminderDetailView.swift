//
//  ReminderDetailView.swift
//  RemindersApp
//
//  Created by ESSIP on 23.08.2024.
//

import SwiftUI

struct ReminderDetailView: View {
    
    @Environment(\.dismiss) private var dismiss
    @Binding var reminder: Reminder
    @State private var editConfig: ReminderEditConfig = ReminderEditConfig()
    private var isFormValid: Bool {
        !editConfig.title.isEmpty
    }
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    Section {
                        TextField("Title", text: $editConfig.title)
                        TextField("Notes", text: $editConfig.notes ?? "")
                    }
                    
                    Section {
                        Toggle(isOn: $editConfig.hasDate) {
                            Image(systemName: "calendar")
                                .foregroundStyle(.red)
                        }
                        if editConfig.hasDate {
                            DatePicker("Select date", selection: $editConfig.reminderDate ?? Date(), displayedComponents: .date)
                        }
                        
                        Toggle(isOn: $editConfig.hasTime) {
                            Image(systemName: "clock")
                                .foregroundStyle(.blue)
                        }
                        
                        if editConfig.hasTime {
                            DatePicker("Select time", selection: $editConfig.reminderTime ?? Date(), displayedComponents: .hourAndMinute)
                        }
                        
                        Section {
                            NavigationLink {
                                SelectListView(selectedList: $reminder.list)
                            } label: {
                                HStack {
                                    Text("List")
                                    Spacer()
                                    Text(reminder.list!.name)
                                }
                            }

                        }
                        
                    }.onChange(of: editConfig.hasDate) { hasDate in
                        if hasDate {
                            editConfig.reminderDate = Date()
                        }
                    }.onChange(of: editConfig.hasTime) { hasTime in
                        if hasTime {
                            editConfig.reminderTime = Date()
                        }
                    }
                    
                }.listStyle(.insetGrouped)
            }.onAppear{
                editConfig = ReminderEditConfig(reminder: reminder)
            }
            .toolbar{
                ToolbarItem(placement: .principal) {
                    Text("Details")
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Done") {
                            do {
                               let _ = try ReminderServices.updateReminder(reminder: reminder, editConfig: editConfig)
                            } catch {
                                print(error)
                        }
                        dismiss()
                    }.disabled(!isFormValid)
                }
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel"){
                        dismiss()
                    }
                }
                
            }
        }
    }
}

#Preview {
    ReminderDetailView(reminder: .constant(PreviewData.reminder))
}
