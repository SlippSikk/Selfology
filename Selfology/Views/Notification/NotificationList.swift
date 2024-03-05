//
//  NotificationList.swift
//  Selfology
//
//  Created by Hamed BAQAIE on 5/3/2024.
//

import SwiftUI

struct NotificationList: View {
    @EnvironmentObject var notificationsManager: NotificationsManager
    var body: some View {
        let noti = notificationsManager.notifications
        ForEach(noti) { item in
            NotificationRow(item: item)
                .padding(EdgeInsets(top: 2, leading: 0, bottom: 7, trailing: 0))
        }
    }
}

#Preview {
    NotificationList()
        .environmentObject(NotificationsManager())
}
