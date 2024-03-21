//
//  NotificationPage.swift
//  Selfology
//
//  Created by Hamed BAQAIE on 11/1/2024.
//

import SwiftUI

struct NotificationPage: View {
    @EnvironmentObject var notificationsManager: NotificationsManager
    @State private var isAddingNewNotification = false
    @State private var expandedItemId: UUID? = nil

    
    var body: some View {

        NavigationStack {
            ZStack {
                Color(#colorLiteral(red: 0.89, green: 0.88, blue: 0.87, alpha: 1)) // Hex #e4e2dd
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    HStack {
                        Spacer()
                        Button(action: {
                            // Create a new notification and prepare to navigate
                            isAddingNewNotification = true
                        }) {
                            PlusButton()
                        }
                    }
                    .padding(.bottom, 35)
                    
                    ScrollView {
                        ForEach(Array(notificationsManager.notifications.enumerated()), id: \.element.id) { index, notification in
                            NotificationRow(item: $notificationsManager.notifications[index], isExpanded: Binding(
                                get: { self.expandedItemId == notification.id },
                                set: { _ in self.expandedItemId = (self.expandedItemId == notification.id) ? nil : notification.id }
                            ))
                            .padding(EdgeInsets(top: 2, leading: 0, bottom: 7, trailing: 0))
                        }
                    }
//                    .onAppear {
//                        notificationsManager.loadNotifications() // Call to refresh notifications
//                    }
                    Spacer()
                    Image("blacklogo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 75, height: 75)
                        .padding(.bottom, 20)
                        .padding(.top, 39)
                }
                .navigationDestination(isPresented: $isAddingNewNotification) {
                    CreateNotification(item: .constant(NotificationItem(
                        id: UUID(),
                        isOn: true,
                        time: Date(),
                        taskName: "Task Name",
                        description: "Task Description",
                        repeatSchedule: [.everyDay]
                    )))
                    .environmentObject(notificationsManager)
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    NotificationPage()
        .environmentObject(NotificationsManager())
}
