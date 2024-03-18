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
    func loadNotifications() {
//        guard let file = Bundle.main.url(forResource: "notificationItems.json", withExtension: nil) else {
//            fatalError("Couldn't find notificationsItems.json in main bundle.")
//        }
//        
//        do {
//            let data = try Data(contentsOf: file)
//            let decoder = JSONDecoder()
//            decoder.dateDecodingStrategy = .iso8601
//            notifications = try decoder.decode([NotificationItem].self, from: data)
//        } catch {
//            fatalError("Couldn't load notificationItems.json from main bundle:\n\(error)")
//        }
        let fileURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("notificationItems.json")
        
        // Check if the file exists in the Document directory (persisted data)
        if FileManager.default.fileExists(atPath: fileURL.path) {
            // Load the persisted data
            do {
                let data = try Data(contentsOf: fileURL)
                notifications = try JSONDecoder().decode([NotificationItem].self, from: data)
            } catch {
                print("Could not load the persisted notifications: \(error)")
            }
        } else {
            // Load the initial data from the bundle as fallback
            guard let bundleURL = Bundle.main.url(forResource: "notificationItems", withExtension: "json") else {
                fatalError("Couldn't find notificationItems.json in main bundle.")
            }
            do {
                let data = try Data(contentsOf: bundleURL)
                notifications = try JSONDecoder().decode([NotificationItem].self, from: data)
                // Optionally, save the initial data to Document directory for future use
                saveNotificationsToFile()
            } catch {
                fatalError("Couldn't load notificationItems.json from main bundle: \(error)")
            }
        }
    }
    
    
    // New or modified saveNotification function. Calls saveNotificationsToFile to do so.
    func saveNotification(_ item: NotificationItem) {
        print("Saving notifications item \(item)")
        
        if let index = notifications.firstIndex(where: { $0.id == item.id }) {
            // Notification exists, remove the old one before updating
            NotificationHandler.shared.deleteNotification(for: notifications[index])
            notifications[index] = item
        } else {
            // New notification, add it
            notifications.append(item)
        }
        saveNotificationsToFile()
        NotificationHandler.shared.scheduleNotification(for: item)
    }

    
    
    // Extracted saving logic to a new function for clarity
    private func saveNotificationsToFile() {
        do {
            let data = try JSONEncoder().encode(notifications)
            let fileURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("notificationItems.json")
            try data.write(to: fileURL, options: .atomic)
            print("Saving notifications to \(fileURL.path)")
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
        if let index = notifications.firstIndex(where: { $0.id == id }) {
            NotificationHandler.shared.deleteNotification(for: notifications[index])
            notifications.remove(at: index)
            saveNotificationsToFile()
        }
    }
    
    //    func deleteNotification(for id: UUID) {
    //        notifications.removeAll { $0.id == id }
    //        saveNotificationsToFile() // Reuse the save logic to persist changes
    //    }
}
