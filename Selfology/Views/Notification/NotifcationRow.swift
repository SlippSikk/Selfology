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
        VStack {
            ZStack {
                RoundedRectangle(cornerRadius: 18)
                    .fill(Color.gray.opacity(0.2))
                    .shadow(radius: 5)

                HStack {
                    Toggle(isOn: $item.isOn) {
                        EmptyView()
                    }
                    .labelsHidden()
                    .toggleStyle(SwitchToggleStyle(tint: .gray))
                    .padding(.leading, 7)
                    Spacer()

                    // Time capsule
                    Text(item.time)
                        .padding(5)
                        .background(
                            RoundedRectangle(cornerRadius: 18)
                                .stroke(Color.gray, lineWidth: 1)
                        )

                    // Task name capsule
                    Text(item.taskName)
                        .padding(5)
                        .background(
                            RoundedRectangle(cornerRadius: 18)
                                .stroke(Color.gray, lineWidth: 1)
                        )
                        
                        
                }
            }
            .contentShape(Rectangle())
            .onTapGesture {
                withAnimation {
                    showDescription.toggle()
                }
            }

            // Conditionally show the description
            if showDescription {
                Text(item.description)
                    .foregroundColor(.gray)
                    .transition(.opacity)
                    .padding([.bottom, .horizontal])
            }
        }
        .frame(height: showDescription ? nil : 50)
        .padding(.horizontal)
    }

}

#Preview {

    NotifcationRow(item: .constant(NotificationItem(isOn: true, time: "6:00 AM", taskName: "MORNING MEDITATION", description: "Description here")))
}
