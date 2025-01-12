//
//  ReminderStatsView.swift
//  RemindersApp
//
//  Created by ESSIP on 28.08.2024.
//

import SwiftUI

struct ReminderStatsView: View {
    
    let icon: String
    let title: String
    var count: Int?
    var iconColor: Color = .blue
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading, spacing: 10) {
                    Image(systemName: icon)
                        .foregroundStyle(iconColor)
                        .font(.title)
                    Text(title)
                        .opacity(0.8)
                }
                Spacer()
                if let count {
                    Text("\(count)")
                        .font(.largeTitle)
                }
                
            }.padding()
                .frame(maxWidth: .infinity)
                .background(colorScheme == .dark ? Color.darkGray : .offWhite)
                .foregroundColor(colorScheme == .dark ? Color.offWhite : .darkGray)
                .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
        }
    }
}

#Preview {
    ReminderStatsView(icon: "calendar", title: "Today", count: 9)
}
