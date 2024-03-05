//
//  ContentView.swift
//  Selfology
//
//  Created by Hamed BAQAIE on 11/1/2024.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var notificationsManager: NotificationsManager
    
    var body: some View {
        NotificationPage()
    }
}

#Preview {
    ContentView()
        .environmentObject(NotificationsManager())
}
