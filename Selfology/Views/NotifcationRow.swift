//
//  NotifcationRow.swift
//  Selfology
//
//  Created by Hamed BAQAIE on 11/1/2024.
//

import SwiftUI

struct NotifcationRow: View {
    @Binding var item: NotificationItem
    @State private var showDescription = false
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.gray.opacity(0.2))
                .shadow(radius: 5)

            VStack {
                HStack() {
                    Toggle(isOn: $item.isOn) {
                        EmptyView()
                    }
                    .toggleStyle(SwitchToggleStyle(tint: .gray))
//                    .padding()
                    Spacer()
                    
                    VStack(alignment: .leading) {
                        Text(item.time)
                            .bold()
                        Text(item.taskName)
                    }
                    Spacer()
                }
                .contentShape(Rectangle())
                .onTapGesture {
                    withAnimation {
                        showDescription.toggle()
                    }
                }
                
                if showDescription {
                    Text(item.description)
                        .foregroundColor(.gray)
                        .transition(.slide)
                        .padding([.bottom, .horizontal])
                }
            }
        }
        .frame(height: showDescription ? nil : 50)
        .padding(.horizontal)
    }

}

#Preview {

    NotifcationRow(item: .constant(NotificationItem(isOn: true, time: "6:00 AM", taskName: "MORNING MEDITATION", description: "Description here")))
}
