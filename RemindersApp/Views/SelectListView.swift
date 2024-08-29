//
//  SelectListView.swift
//  RemindersApp
//
//  Created by ESSIP on 24.08.2024.
//

import SwiftUI

struct SelectListView: View {
    
    @FetchRequest(sortDescriptors: [])
    private var myListsFetchResults: FetchedResults<MyList>
    @Binding var selectedList: MyList?
    
    private func deleteList(_ indexSet: IndexSet){
        indexSet.forEach { index in
            let list = myListsFetchResults[index]
            do {
                try ReminderServices.deleteList(list)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    var body: some View {
        List{
            ForEach(myListsFetchResults) { myList in
                HStack {
                    HStack{
                        Image(systemName: "line.3.horizontal.circle.fill")
                            .foregroundStyle(Color(myList.color))
                        Text(myList.name)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .contentShape(Rectangle())
                    .onTapGesture {
                        self.selectedList = myList
                    }
                    Spacer()
                    if selectedList == myList {
                        Image(systemName: "checkmark")
                    }
                }
            }.onDelete(perform: deleteList)
        }
    }
}

#Preview {
    SelectListView(selectedList: .constant(PreviewData.myList))
        .environment(\.managedObjectContext, CoreDataprovider.shared.persistentContainer.viewContext)
}
