//
//  CreateNotifcationPage.swift
//  Selfology
//
//  Created by Albert Kim on 11/1/2024.
//

import SwiftUI

struct ReminderView: View {
    @State private var selectedDate = Date()
    @State private var taskName = "TASK NAME"
    @State private var repeatFrequency = RepeatSchedule.everyDay
    @State var item: NotificationItem
    @ObservedObject var notificationsManager: NotificationsManager
    @Environment(\.presentationMode) var presentationMode
    
    let customGray = Color(red: 43.0 / 255.0, green: 43.0 / 255.0, blue: 43.0 / 255.0)
    
    var body: some View {
        ZStack {
            NavigationStack {
                Form {
                    
                    Section {
                        DatePicker("Time", selection: $selectedDate, displayedComponents: .hourAndMinute)
                            .datePickerStyle(WheelDatePickerStyle())
                            .labelsHidden()
                    }
                    .listRowBackground(Color.clear)
                    
                    Section {
                        HStack {
                            Text("Task")
                            
                                .foregroundColor(.black)
                            Spacer()
                            TextField("TASK NAME", text: $taskName)
                                .multilineTextAlignment(.trailing)
                                .foregroundColor(.gray)
                            
                        }
                        .listRowBackground(Color.gray.opacity(0.11))
                        
                        Picker("Repeat", selection: $repeatFrequency) {
                            ForEach(RepeatSchedule.allCases, id: \.self) { frequency in
                                Text(frequency.rawValue).tag(frequency)
                            }
                        }
                        .listRowBackground(Color.gray.opacity(0.11))
                    }
                    
                    
                    Section {
                        Button(action: {
                            // Action to delete notification vvv
                            notificationsManager.deleteNotification(for: item.id)
                            // Action to delete notification ^^^
                            
                        }) {
                            Text("DELETE NOTIFICATION")
                                .frame(maxWidth: .infinity, alignment: .center)
                                .foregroundColor(.red)
                                
                        }
                        
                    }
                    .listRowBackground(Color.gray.opacity(0.11))
                    .cornerRadius(50)
                }
                .background(Color(#colorLiteral(red: 0.89, green: 0.88, blue: 0.87, alpha: 1)))
                .scrollContentBackground(.hidden)
                .navigationBarItems(leading: Button("CANCEL")
                {
                    // Cancel logic vvv
                    presentationMode.wrappedValue.dismiss()
                    // Cancel logic ^^^
                }, trailing: Button("SAVE")
                {
                    // Save logic vvv
                    // Create or update the notification item with the current form values
                    let updatedItem = NotificationItem(id: item.id, // Keep the original ID to update the existing notification
                                                        isOn: item.isOn, // Keep the original isOn status or modify as needed
                                                        time: selectedDate,
                                                        taskName: taskName,
                                                        description: item.description, // Assuming description remains unchanged or provide a way to update it
                                                        repeatSchedule: repeatFrequency)

                    // Call saveNotification to save the changes
                    notificationsManager.saveNotification(updatedItem)
                    // Save logic ^^^
                })
                .foregroundColor(.black)
                .background(Color.black)
            }
        }
    }
}

struct ReminderView_Previews: PreviewProvider {
    static var previews: some View {
        // Create an instance of NotificationsManager
        let notificationsManager = NotificationsManager()

        // Pass the notificationsManager instance to the ReminderView
        Group {
            ReminderView(item: NotificationItem(isOn: true, time: Date(), taskName: "Meditate", description: "Wake Up and Meditate to Free The Soul for today is a bright day worth living. And we must be thankful to God for blessing us and our families.", repeatSchedule: .everyMonday), notificationsManager: notificationsManager)
            ReminderView(item: NotificationItem(isOn: true, time: Date(), taskName: "Exercise", description: "Morning exercise session to energize the body for the day ahead.", repeatSchedule: .everyTuesday), notificationsManager: notificationsManager)
        }
    }
}
