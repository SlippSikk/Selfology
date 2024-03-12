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
    @EnvironmentObject var notificationsManager: NotificationsManager
    @Environment(\.presentationMode) var presentationMode
    @State private var shouldNavigateToNotificationPage = false
    @State private var showingRepeatScheduleSheet = false

    
    let customGray = Color(red: 43.0 / 255.0, green: 43.0 / 255.0, blue: 43.0 / 255.0)
    
    var body: some View {
        ZStack {
            NavigationStack {
                Form {
                    
                    Section {
                        DatePicker("Time", selection: $item.time, displayedComponents: .hourAndMinute)
                            .datePickerStyle(WheelDatePickerStyle())
                            .labelsHidden()
                    }
                    .listRowBackground(Color.clear)
                    
                    Section {
                        HStack {
                            Text("Task")
                            
                                .foregroundColor(.black)
                            Spacer()
                            TextField("TASK NAME", text: $item.taskName)
                                .multilineTextAlignment(.trailing)
                                .foregroundColor(.gray)
                            
                        }
                        .listRowBackground(Color.gray.opacity(0.11))
                        
                        Button(action: {
                                showingRepeatScheduleSheet = true
                            }) {
                                HStack {
                                    Text("Repeat Schedule")
                                    Spacer()
                                    Text(item.repeatSchedule.map { $0.rawValue }.joined(separator: ", "))
                                        .foregroundColor(.gray)
                                }
                            }
                            .sheet(isPresented: $showingRepeatScheduleSheet) {
                                // Now use a view that contains the list for selecting repeat schedules
                                RepeatScheduleSelector(repeatSchedules: $item.repeatSchedule)
                            }
                        .listRowBackground(Color.gray.opacity(0.11))
                    }
                    
                    
                    
                    
                    Section {
                        Button(action: {
                            // Action to delete notification
                            notificationsManager.deleteNotification(for: item.id)
                            // After deletion, trigger navigation
                            shouldNavigateToNotificationPage = true
                        }) {
                            Text("DELETE NOTIFICATION")
                                .frame(maxWidth: .infinity, alignment: .center)
                                .foregroundColor(.red)
                        }
                        // This NavigationLink is hidden and only serves to trigger the navigation when shouldNavigate becomes true
                        .navigationDestination(isPresented: $shouldNavigateToNotificationPage) {
                            NotificationPage() // Destination
                        }
                        .transition(.move(edge: .trailing))
                    }
                    .listRowBackground(Color.gray.opacity(0.11))

                }
                .background(Color(#colorLiteral(red: 0.89, green: 0.88, blue: 0.87, alpha: 1)))
                .scrollContentBackground(.hidden)
                .navigationBarItems(leading: Button("CANCEL")
                {
                    // Cancel logic vvv
                    presentationMode.wrappedValue.dismiss()
                    // Cancel logic ^^^
                    
                    shouldNavigateToNotificationPage = true
                    
                    
                    
                }, trailing: Button("SAVE")
                {
                    // Save logic vvv
                    // Create or update the notification item with the current form values
                    let updatedItem = NotificationItem(id: item.id, // Keep the original ID to update the existing notification
                                                        isOn: item.isOn, // Keep the original isOn status or modify as needed
                                                       time: item.time,
                                                       taskName: item.taskName,
                                                        description: item.description, // Assuming description remains unchanged or provide a way to update it
                                                       repeatSchedule: item.repeatSchedule)

                    // Call saveNotification to save the changes
                    notificationsManager.saveNotification(updatedItem)
                    // Save logic ^^^
                    
                    shouldNavigateToNotificationPage = true
                })
                .foregroundColor(.black)
                .background(Color.black)
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct RepeatScheduleSelector: View {
    @Binding var repeatSchedules: [RepeatSchedule]
    @Environment(\.presentationMode) var presentationMode

    //let lightBackground = Color(#colorLiteral(red: 0.89, green: 0.88, blue: 0.87, alpha: 1))
    let lightBackground = Color.gray.opacity(0.11)
    let borderColor = Color.gray.opacity(0.5)

    var body: some View {
        NavigationView {

            ForEach(RepeatSchedule.allCases, id: \.self) { frequency in
                Button(action: {
                    toggleSelection(for: frequency)
                }) {
                    // First element in list
                    if frequency == RepeatSchedule.allCases.first {
                        HStack {
                            
                            Text(frequency.rawValue)
                            
                            Spacer()
                            
                            if repeatSchedules.contains(frequency) {
                                Image(systemName: "checkmark")
                                    .foregroundColor(.black)
                            }
                        }
                        .padding(.horizontal, 15)
                        .padding(.vertical, 9)
                        .padding(.top, 6.9)
                    }
                    
                    // Last element in list
                    else if (frequency == RepeatSchedule.allCases.last ) {
                        HStack {
                            
                            Text(frequency.rawValue)
                            
                            Spacer()
                            
                            if repeatSchedules.contains(frequency) {
                                Image(systemName: "checkmark")
                                    .foregroundColor(.black)
                            }
                        }
                        .padding(.horizontal, 15)
                        .padding(.vertical, 15)
                        .padding(.top, -6)
                    }
                    
                    // All the other elements in the list
                    else {
                        HStack {
                            
                            Text(frequency.rawValue)
                            
                            Spacer()
                            
                            if repeatSchedules.contains(frequency) {
                                Image(systemName: "checkmark")
                                    .foregroundColor(.black)
                            }
                        }
                        .padding(.vertical, 8)
                        .padding(.horizontal, 15)
                    }

                }
                .buttonStyle(BorderlessButtonStyle())
                
                // Only add a divider if it's not the last item
                if frequency != RepeatSchedule.allCases.last {
                    Divider().padding(.horizontal, 10)
                }
            }
            .background(lightBackground)
            .cornerRadius(10)
            .padding(.top, -250)
//            .overlay(
//                RoundedRectangle(cornerRadius: 10)
//                    .stroke(borderColor, lineWidth: 1)
//            )
            .navigationBarTitle("Repeat", displayMode: .inline)
            .navigationBarItems(leading: Button(action: {
                self.presentationMode.wrappedValue.dismiss()
            }) {
                HStack {
                    Image(systemName: "chevron.left")
                    Text("Back")
                }
            })
        }
        .padding(.horizontal, 20)
        
    }

    private func toggleSelection(for schedule: RepeatSchedule) {
        if let index = repeatSchedules.firstIndex(of: schedule) {
            repeatSchedules.remove(at: index)
        } else {
            repeatSchedules.append(schedule)
        }
    }
}

// Assuming RepeatSchedule enum is defined as before




struct ReminderView_Previews: PreviewProvider {
    static var previews: some View {
        // Assuming NotificationsManager is correctly handling the updated NotificationItem structure
        let notificationsManager = NotificationsManager()

        Group {
            // Updated to pass an array of RepeatSchedule values to match the updated NotificationItem structure
            ReminderView(item: NotificationItem(isOn: true, time: Date(), taskName: "Meditate", description: "Wake Up and Meditate to Free The Soul for today is a bright day worth living. And we must be thankful to God for blessing us and our families.", repeatSchedule: [.everyMonday]))
            .environmentObject(notificationsManager) // Provide the notificationsManager as an EnvironmentObject
            
            ReminderView(item: NotificationItem(isOn: true, time: Date(), taskName: "Exercise", description: "Morning exercise session to energize the body for the day ahead.", repeatSchedule: [.everyTuesday]))
            .environmentObject(notificationsManager) // Provide the notificationsManager as an EnvironmentObject
        }
    }
}
