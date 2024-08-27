//
//  ReminderCellView.swift
//  RemindersApp
//
//  Created by ESSIP on 23.08.2024.
//

import SwiftUI

enum ReminderCellEvents {
    case onInfo
    case onSelect(Reminder)
    case onCheckedChange(Reminder, Bool)
}

struct ReminderCellView: View {
    
    let reminder: Reminder
    let delay = Delay()
    let isSelected: Bool
    
    @State private var checked: Bool = false
    let onEvent: (ReminderCellEvents) -> ()
    
    
    private func formatDate(_ date: Date) -> String {
        if date.isToday {
            return "Today"
        } else if date.isTomorrow {
            return "Tomorrow"
        } else {
            return date.formatted(date: .numeric, time: .omitted)
        }
    }
    
    var body: some View {
        HStack {
            Image(systemName: checked ? "circle.inset.filled" : "circle")
                .font(.title2)
                .opacity(0.4)
                .onTapGesture {
                    checked.toggle()
                    //cancel the old task
                    delay.cancel()
                    //call onCheckedChange
                    delay.performWork {
                        onEvent(.onCheckedChange(reminder, checked))
                    }
                }
            
            VStack(alignment: .leading){
                Text(reminder.title ?? "")
                
                if let notes = reminder.notes, !notes.isEmpty {
                    Text(notes)
                        .opacity(0.4)
                        .font(.caption)
                }
                
                HStack {
                    if let reminderDate = reminder.reminderDate {
                        Text(formatDate(reminderDate))
                    }
                    
                    if let reminderTime = reminder.reminderTime {
                        Text(reminderTime.formatted(date: .omitted, time: .shortened))
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.caption)
                .opacity(0.4)
            }
            Spacer()
            Image(systemName: "info.circle.fill")
                .opacity(isSelected ? 1.0 : 0.0)
                .onTapGesture {
                    onEvent(.onInfo)
                }
        }.contentShape(Rectangle())
            .onTapGesture {
                onEvent(.onSelect(reminder))
            }
    }
}

#Preview {
    ReminderCellView(reminder: PreviewData.reminder, isSelected: false, onEvent: {_ in })
}
