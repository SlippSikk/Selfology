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
    
    let customGray = Color(red: 43.0 / 255.0, green: 43.0 / 255.0, blue: 43.0 / 255.0)

    var body: some View {
        VStack {
            ZStack {
                RoundedRectangle(cornerRadius: 18)
                    .fill(Color.gray.opacity(0.11))
                    .shadow(radius: 5)

                HStack {
                    Spacer()
                    Toggle(isOn: $item.isOn) {
                        EmptyView()
                    }
                    .labelsHidden()
                    .toggleStyle(SwitchToggleStyle(tint: customGray))
//                    .padding(.leading, 7)
                    
                    Spacer(minLength: 25)

                    // Time capsule
                    Text(formatDate(item.time))
                        .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))                        
                        .font(.subheadline)
                        .frame(width: 80, height: 31)
                        .background(
                            RoundedRectangle(cornerRadius: 18)
                                .stroke(customGray, lineWidth: 1)
                        )
                    
                    Spacer(minLength: 25)
                    
                    // Task name capsule
                    Text(item.taskName)
                        .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10)) // Adjust padding as needed
                        .frame(width: 160, height: 31)
                        .font(.subheadline)
                        .background(
                            RoundedRectangle(cornerRadius: 18)
                                .stroke(customGray, lineWidth: 1)
                        )
                        

                    Spacer() // Flexible space
                    
                    // Invisible spacer to balance the leading padding
//                    Spacer().frame(width: 7).hidden()
                        
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
    
    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }

}

#Preview {

    NotifcationRow(item: .constant(NotificationItem(isOn: true, time: Date(), taskName: "Meditate", description: "Description here")))
}
