//
//  NotificationPage.swift
//  Selfology
//
//  Created by Hamed BAQAIE on 11/1/2024.
//

import SwiftUI

struct NotificationPage: View {
    var body: some View {
        ZStack {
            Color(#colorLiteral(red: 0.89, green: 0.88, blue: 0.87, alpha: 1)) // Hex #e4e2dd
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                HStack {
                    Spacer()
                    PlusButton()
                }
                Spacer()
                Image("blacklogo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 75, height: 75)
                    .padding(.bottom, 20)
            }
        }
    }
}

#Preview {
    NotificationPage()
}
