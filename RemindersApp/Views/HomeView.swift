//
//  ContentView.swift
//  RemindersApp
//
//  Created by ESSIP on 22.08.2024.
//

import SwiftUI

struct HomeView: View {
    
    //MARK: -Properties
    @FetchRequest(sortDescriptors: [])
    private var myListResults: FetchedResults<MyList>
    @FetchRequest(sortDescriptors: [])
    private var searchResults: FetchedResults<Reminder>

    @State private var search: String = ""
    @State private var isPresented: Bool = false
    @State private var searching: Bool = false
    
    @FetchRequest(fetchRequest: ReminderServices.reminderByStatType(statType: .today))
    private var todayResults: FetchedResults<Reminder>
    @FetchRequest(fetchRequest: ReminderServices.reminderByStatType(statType: .all))
    private var allResults: FetchedResults<Reminder>
    @FetchRequest(fetchRequest: ReminderServices.reminderByStatType(statType: .scheduled))
    private var scheduledResults: FetchedResults<Reminder>
    @FetchRequest(fetchRequest: ReminderServices.reminderByStatType(statType: .completed))
    private var completedResults: FetchedResults<Reminder>
    private var reminderStatsBuilder = ReminderStatsBuilder()
    @State private var reminderStatsValues = ReminderStatsValues()
    
    //MARK: -Body
    var body: some View {
        NavigationStack{
                VStack {
                    ScrollView{
                        HStack {
                            NavigationLink {
                                ReminderListView(reminders: todayResults)
                            } label: {
                                ReminderStatsView(icon: "calendar", title: "Today", count: reminderStatsValues.todayCount)
                            }
                            NavigationLink {
                                ReminderListView(reminders: allResults)
                            } label: {
                                ReminderStatsView(icon: "tray.circle.fill", title: "All", count: reminderStatsValues.allCount, iconColor: .red)
                            }
                        }
                        HStack {
                            NavigationLink {
                                ReminderListView(reminders: scheduledResults)
                            } label: {
                                ReminderStatsView(icon: "calendar.circle.fill", title: "Scheduled", count: reminderStatsValues.scheduleCount, iconColor: .secondary)
                            }
                            NavigationLink {
                                ReminderListView(reminders: completedResults)
                            } label: {
                                ReminderStatsView(icon: "checkmark.circle.fill", title: "Completed", count: reminderStatsValues.completedCount, iconColor: .black)
                            }
                        }
                        
                        Text("My Lists")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .font(.largeTitle)
                            .bold()
                            .padding()
                        
                    MyListView(myLists: myListResults)
                    
                    
                    
                    Button {
                        isPresented = true
                    } label: {
                        Text("Add list")
                            .frame(maxWidth: .infinity, alignment: .trailing)
                            .font(.headline)
                    }.padding()
                    }.listStyle(.plain)
                .onChange(of: search, perform: { searchTerm in
                    searching = !searchTerm.isEmpty ? true : false
                    searchResults.nsPredicate = ReminderServices.getRemindersBySearchTerm(search).predicate
                    
                })
                .overlay(alignment: .center, content: {
                    ReminderListView(reminders: searchResults)
                        .opacity(searching ? 1.0 : 0.0)
                }).onAppear {
                    reminderStatsValues = reminderStatsBuilder.build(myListResults: myListResults)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .sheet(isPresented: $isPresented) {
                    NavigationView {
                        AddNewListView { name, color in
                            do {
                                try ReminderServices.saveMyList(name, color: color)
                            } catch {
                                print(error.localizedDescription)
                            }
                        }
                    }
                }
            }
            .padding()
            .navigationTitle("Reminders")
        }.searchable(text: $search)
    }
}

#Preview {
    HomeView()
        .environment(\.managedObjectContext, CoreDataprovider.shared.persistentContainer.viewContext)

}
