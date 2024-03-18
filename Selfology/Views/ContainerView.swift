//
//  ContainerView.swift
//  Selfology
//
//  Created by Albert Kim on 13/3/2024.
//

import SwiftUI

struct ContainerView: View {
    @StateObject private var viewModel = AppViewModel() // Initialize the ViewModel
    var notificationsManager = NotificationsManager()
    
    var body: some View {
        Group {
            if viewModel.showSplashScreen {
                SplashScreenView(viewModel: viewModel) // Pass the ViewModel to SplashScreenView
            } else {
                ContentView()
                    .environmentObject(notificationsManager)
                    .onAppear {
                        NotificationHandler.shared.askPermission()
                    }
            }
        }
    }
}

#Preview {
    ContainerView()
}
