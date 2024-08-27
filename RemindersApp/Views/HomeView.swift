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
    
    @State private var isPresented: Bool = false
    
    var body: some View {
        NavigationStack{
            VStack {
                MyListView(myLists: myListResults)
                
//                Spacer()
                
                Button {
                    isPresented = true
                } label: {
                    Text("Add list")
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .font(.headline)
                }.padding()
            }.sheet(isPresented: $isPresented) {
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
    }
}

#Preview {
    HomeView()
        .environment(\.managedObjectContext, CoreDataprovider.shared.persistentContainer.viewContext)

}
