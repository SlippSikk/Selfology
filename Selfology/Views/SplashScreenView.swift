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
                Image("blacklogo") // logo
                    .resizable()
                    .scaledToFit()
                    .frame(width: 90, height: 90)
                    .rotationEffect(Angle(degrees: angle))
                    .onAppear {
                        // Use easeOut to slow down the animation over time
                        withAnimation(Animation.easeOut(duration: 2)) {
                            self.angle = 270
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.8) {
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
