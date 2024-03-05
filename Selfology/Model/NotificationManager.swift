//
//  NotificationManager.swift
//  Selfology
//
//  Created by Hamed BAQAIE on 5/3/2024.
//

import Foundation

class NotificationsManager: ObservableObject {
    @Published var notifications: [NotificationItem] = []
    
    init() {
        loadNotifications()
    }
    
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
    
    func saveNotifications() {
        do {
            let data = try JSONEncoder().encode(notifications)
            let fileURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("notificationItems.json")
            try data.write(to: fileURL, options: .atomic)
        } catch {
            print("Error saving notifications: \(error)")
        }
    }
    
    func toggleNotification(isOn: Bool, for id: UUID) {
        if let index = notifications.firstIndex(where: { $0.id == id }) {
            notifications[index].isOn = isOn
            saveNotifications()
        }
    }
}
