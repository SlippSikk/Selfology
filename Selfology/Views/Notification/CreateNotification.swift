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
                    .listRowBackground(Color.clear)                //.background(Color(clear))
                    
                    Section {
                        HStack {
                            Text("Task")
                            
                                .foregroundColor(.black)
                            Spacer()
                            TextField("MORNING MEDITATION", text: $taskName)
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
                        //.cornerRadius(18)
                        
                    }
                    
                    
                    Section {
                        Button(action: {
                            // Action to delete notification
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
                    // cancel logic
                }, trailing: Button("SAVE") 
                {
                    // save logic
                })
                .foregroundColor(.black)
                .background(Color.black)
            }
        }
    }
}

struct ReminderView_Previews: PreviewProvider {
    static var previews: some View {
        ReminderView()
    }
}

