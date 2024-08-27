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
    
    var body: some View {
        List(myListsFetchResults) { myList in
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
        }
    }
}

#Preview {
    SelectListView(selectedList: .constant(PreviewData.myList))
        .environment(\.managedObjectContext, CoreDataprovider.shared.persistentContainer.viewContext)
}
