//
//  NotifcationRow.swift
//  Selfology
//
//  Created by Hamed BAQAIE on 11/1/2024.
//

import SwiftUI


struct NotificationRow: View {
    @Binding var item: NotificationItem
    @State private var showDescription = false
    @EnvironmentObject var notificationsManager: NotificationsManager
    @State private var shouldNavigateToCreateNotification = false
    
    let customGray = Color(red: 43.0 / 255.0, green: 43.0 / 255.0, blue: 43.0 / 255.0)

    var body: some View {
        VStack {
            ZStack {
                RoundedRectangle(cornerRadius: 18)
                    .fill(Color.gray.opacity(showDescription ? 0.05 : 0.00))
                    .shadow(radius: showDescription ? 0 : 5)
                    .animation(.easeInOut, value: showDescription)
                
                VStack {
                    HStack {
                        Spacer().frame(width: 7).hidden()
                        if #available(iOS 17.0, *) {
                            Toggle(isOn: $item.isOn) {
                                EmptyView()
                            }
                            .labelsHidden()
                            .toggleStyle(SwitchToggleStyle(tint: customGray))
                            // Use .onChange for iOS 17 and above
                            .onChange(of: item.isOn, initial: false, { oldValue ,newValue  in
                                notificationsManager.toggleNotification(isOn: newValue, for: item.id)
                                
                            })
                        } else {
                            Toggle(isOn: $item.isOn) {
                                EmptyView()
                            }
                            .labelsHidden()
                            .toggleStyle(SwitchToggleStyle(tint: customGray))
                            // Use .onChange for iOS 16 and below
                            .onChange(of: item.isOn) { newValue in
                                notificationsManager.toggleNotification(isOn: newValue, for: item.id)
                            }
                        }
                        
                        
                        Spacer(minLength: 25)
                        ZStack {
                            HStack {
                                // Time capsule
                                Text(formatDate(item.time))
                                    .font(.subheadline)
                                    .frame(width: 80, height: 31)
                                    .background(
                                        RoundedRectangle(cornerRadius: 18)
                                            .stroke(customGray, lineWidth: 1)
                                    )
                                
                                Spacer(minLength: 25)
                                
                                // Task name capsule
                                Text(item.taskName)
                                    .frame(width: 160, height: 31)
                                    .font(.subheadline)
                                    .background(
                                        RoundedRectangle(cornerRadius: 18)
                                            .stroke(customGray, lineWidth: 1)
                                    )
                                
                                // Invisible spacer to balance the leading padding
                                Spacer().frame(width: 7).hidden()
                            }
                        }
                        .contentShape(Rectangle())
                        .onTapGesture {
                            withAnimation(.easeInOut) {
                                showDescription.toggle()
                            }
                        }
                    }
                    .padding(EdgeInsets(top: 7, leading: 0, bottom:7, trailing: 0))

                    if showDescription {
                        DynamicHeightTextEditor(text: $item.description)
                            .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
                            .scrollContentBackground(.hidden)
                            
                        // In NotificationRow, adjust to trigger selection change on button tap:
                        NavigationLink(destination: CreateNotification(item: $item)) {
                            Image(systemName: "ellipsis")
                                .font(.title)
                                .foregroundColor(.primary)
                        }
                        .padding(EdgeInsets(top: 2, leading: 0, bottom: 10, trailing: 10))
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .padding(EdgeInsets(top: 2, leading: 0, bottom: 10, trailing: 10)) // Adjust padding as needed
                        .frame(maxWidth: .infinity, alignment: .trailing)
                    }
                }
            }
            .fixedSize(horizontal: false, vertical: true)

        }
        .background(Color.gray.opacity(0.11))
        .cornerRadius(18)
        .padding(.horizontal)
//        .animation(.easeInOut, value: showDescription)
    }

    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
}

struct NotificationRow_Previews: PreviewProvider {
    static var previews: some View {
        NotificationRow(item: .constant(NotificationItem(isOn: true, time: Date(), taskName: "Meditate", description: "Wake Up and Meditate to Free The Soul for today is a bright day worth living. And we must be thankful to God for blessing us and our families.", repeatSchedule: [.everyMonday])))
            .environmentObject(NotificationsManager())
    }
}
