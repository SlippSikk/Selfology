//
//  SplashScreenView.swift
//  Selfology
//
//  Created by Albert Kim on 13/3/2024.
//

import SwiftUI

struct SplashScreenView: View {
    @ObservedObject var viewModel: AppViewModel // Use the shared ViewModel
    @State private var size: CGFloat = 1.0
    @State private var opacity: Double = 1.0

    var body: some View {
        ZStack {
            Color(#colorLiteral(red: 0.89, green: 0.88, blue: 0.87, alpha: 1)) // Hex #e4e2dd
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Image("blacklogo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .scaleEffect(size)
                    .opacity(opacity)
                    .onAppear {
                        withAnimation(.easeIn(duration: 1.2)) {
                            self.size = 0.9
                            self.opacity = 0.2
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            withAnimation {
                                self.viewModel.showSplashScreen = false
                            }
                        }
                    }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        //.background(Color.white.edgesIgnoringSafeArea(.all))
        }
    }
}


struct SplashScreenView_Previews: PreviewProvider {
    static var previews: some View {
        // Create an instance of AppViewModel for the preview
        SplashScreenView(viewModel: AppViewModel())
    }
}

