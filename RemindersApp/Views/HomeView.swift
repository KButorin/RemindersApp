//
//  ContentView.swift
//  RemindersApp
//
//  Created by ESSIP on 22.08.2024.
//

import SwiftUI

struct HomeView: View {
    
    @FetchRequest(sortDescriptors: [])
    private var myListResults: FetchedResults<MyList>
    
    @FetchRequest(sortDescriptors: [])
    private var searchResults: FetchedResults<Reminder>
    
    @State private var search: String = ""
    @State private var isPresented: Bool = false
    @State private var searching: Bool = false
    
    var body: some View {
        NavigationStack{
                VStack {
                    ScrollView{
                    MyListView(myLists: myListResults)
                    
                    //                Spacer()
                    
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
                }).frame(maxWidth: .infinity, maxHeight: .infinity)
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
