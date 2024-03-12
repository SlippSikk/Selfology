//
//  NotificationManager.swift
//  Selfology
//
//  Created by Hamed BAQAIE on 5/3/2024.
//

import Foundation

class NotificationsManager: ObservableObject {
    @Published var notifications: [NotificationItem] = []
    @Published var newItem: NotificationItem?
    
    // Calls loadNotifications to initialise files
    init() {
        loadNotifications()
    }
    
    // Create a new instance of a notification
    func createNotification() -> NotificationItem {
        let newItem = NotificationItem(id: UUID(), isOn: true, time: Date(), taskName: "Task Name", description: "Task Description", repeatSchedule: [.everyDay])
        notifications.append(newItem)
        return newItem
    }
    
    // Loads all the JSON files
    private func loadNotifications() {
        guard let file = Bundle.main.url(forResource: "notificationItems.json", withExtension: nil) else {
            fatalError("Couldn't find notificationsItems.json in main bundle.")
        }
        
        do {
            let data = try Data(contentsOf: file)
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            notifications = try decoder.decode([NotificationItem].self, from: data)
        } catch {
            fatalError("Couldn't load notificationItems.json from main bundle:\n\(error)")
        }
    }
    
    
    // New or modified saveNotification function. Calls saveNotificationsToFile to do so.
    func saveNotification(_ item: NotificationItem) {
        //print("Saving notifications item \(item)")
        if let index = notifications.firstIndex(where: { $0.id == item.id }) {
            // Notification exists, update it
            notifications[index] = item
        } else {
            // New notification, add it
            notifications.append(item)
        }
        //print("Here are the notifications: \(notifications)")
        // Save the updated notifications array to file
        saveNotificationsToFile()
    }
    
    
    // Extracted saving logic to a new function for clarity
    private func saveNotificationsToFile() {
        do {
            let data = try JSONEncoder().encode(notifications)
            let fileURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("notificationItems.json")
            try data.write(to: fileURL, options: .atomic)
            //print("Saving notifications to \(fileURL.path)")
        } catch {
            print("Error saving notifications: \(error)")
        }
    }
    
    
    // Modifies the notification. Calls saveNotification to do so.
    func toggleNotification(isOn: Bool, for id: UUID) {
        if let index = notifications.firstIndex(where: { $0.id == id }) {
            var item = notifications[index]
            item.isOn = isOn
            saveNotification(item) // Use the refactored save method
        } else {
            print("Notification with ID \(id) not found.")
        }
    }
    
    
    // Deletes a notification. Calls saveNotificationsToFile to do so.
    func deleteNotification(for id: UUID) {
        notifications.removeAll { $0.id == id }
        saveNotificationsToFile() // Reuse the save logic to persist changes
    }


    
}
