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
//                .padding(EdgeInsets(top: 0, leading: 0, bottom: 5, trailing: 0))
                NotificationRow(item: (NotificationItem(isOn: true, time: Date(), taskName: "Meditate", description: "Wake Up and Meditate to Free The Soul for today is a bright day worth lving. And we must be thankful to God for blessing us and our families. ")))
                NotificationRow(item: (NotificationItem(isOn: true, time: Date(), taskName: "Swim", description: "10 Laps of Freestyle and 12 Laps of Breast Stroke")))
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
