//
//  AddNewListView.swift
//  RemindersApp
//
//  Created by ESSIP on 22.08.2024.
//

import SwiftUI

struct AddNewListView: View {
    @State public var name: String = ""
    @State public var selectedColor: Color = .green
    @Environment(\.dismiss) private var dissmiss
    
    let onSave: (String, UIColor) -> ()
    
    private var isFormValid: Bool {
        !name.isEmpty
    }
    
    
    var body: some View {
        VStack {
            VStack {
                Image(systemName: "line.3.horizontal.circle.fill")
                    .font(.system(size: 100))
                    .foregroundStyle(selectedColor)
                TextField("List name", text: $name)
                    .multilineTextAlignment(.center)
                    .textFieldStyle(.roundedBorder)
            }
            .padding()
            .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
            ColorPickerView(selectedColor: $selectedColor)
            Spacer()
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("New List")
                        .font(.headline)
                }
                ToolbarItem(placement: .topBarLeading) {
                    Button("Close"){
                        dissmiss()
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Done"){
                        onSave(name, UIColor(selectedColor))
                        dissmiss()
                    }.disabled(!isFormValid)
                }
            }
    }
}

#Preview {
    NavigationStack {
        AddNewListView(onSave: {(_, _) in })
    }
}
