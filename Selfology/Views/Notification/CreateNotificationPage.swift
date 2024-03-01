//
//  CreateNotificationPage.swift
//  Selfology
//
//  Created by Albert Kim on 14/2/2024.
//

import SwiftUI

struct CreateNotificationPage: View {
    @State private var selectedDate = Date()
    @State private var taskName = "MORNING MEDITATION"
    @State private var repeatFrequency = "EVERY DAY"
    
    var body: some View {
        ZStack {
            Color.pink.edgesIgnoringSafeArea(.all) // Set the background color to pink

            Form {
                Section {
                    HStack {
                        Text("Task")
                            .foregroundColor(.black) // You might want to adjust this color for better visibility against a pink background
                        Spacer()
                        TextField("MORNING MEDITATION", text: $taskName)
                            .multilineTextAlignment(.trailing)
                            .foregroundColor(.gray) // Adjust as needed for visibility
                    }
                    .listRowBackground(Color.gray.opacity(0.11))

                    Picker("Repeat", selection: $repeatFrequency) {
                        ForEach(["EVERY DAY", "EVERY WEEK", "EVERY MONTH"], id: \.self) { frequency in
                            Text(frequency).tag(frequency)
                        }
                    }
                    .listRowBackground(Color.gray.opacity(0.11))
                }
            }
            .foregroundColor(.brown)
            .tint(.pink)
            .background(Color.pink)
            .scrollContentBackground(.hidden)
            .navigationBarTitle("Settings")
        }

    }
}

#Preview {
    CreateNotificationPage()
}
