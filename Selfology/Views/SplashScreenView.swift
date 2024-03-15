//
//  SplashScreenView.swift
//  Selfology
//
//  Created by Albert Kim on 13/3/2024.
//

import SwiftUI

struct SplashScreenView: View {
    @ObservedObject var viewModel: AppViewModel // Use the shared ViewModel
    @State private var angle: Double = 0

    var body: some View {
        ZStack {
            Color(#colorLiteral(red: 0.89, green: 0.88, blue: 0.87, alpha: 1)) // Background color
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Image("blacklogo") // Your logo here
                    .resizable()
                    .scaledToFit()
                    .frame(width: 110, height: 110)
                    .rotationEffect(Angle(degrees: angle))
                    .onAppear {
                        // Use easeOut to slow down the animation over time
                        withAnimation(Animation.easeOut(duration: 1.5)) {
                            self.angle = 270
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.4) {
                            withAnimation {
                                self.viewModel.showSplashScreen = false
                            }
                        }
                    }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}

struct SplashScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreenView(viewModel: AppViewModel())
    }
}
