//
//  NotificationHandler.swift
//  Selfology
//
//  Created by Albert Kim on 17/3/2024.
//

import Foundation
import UserNotifications

class NotificationHandler: NSObject, UNUserNotificationCenterDelegate {
    static let shared = NotificationHandler()

    //private init() {}
    
    override init() {
        super.init()
        UNUserNotificationCenter.current().delegate = self
    }

    // Handle notification while app is in the foreground
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.banner, .sound]) // Customize as needed
    }
    
    func askPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
            if success {
                print("Access granted!")
            } else if let error = error {
                print(error.localizedDescription)
            }
        }
    }

    func scheduleNotification(for item: NotificationItem) {
        guard item.isOn else { return } // Ensure the notification is enabled

        let content = UNMutableNotificationContent()
        content.title = "SELFOLOGY."
        content.body = "It's time to \(item.taskName)"
        content.sound = UNNotificationSound.default

        // Configure the recurring date.
        for repeatDay in item.repeatSchedule {
            let trigger = createTrigger(for: repeatDay, at: item.time)

            // Create the request
            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

            // Add request to the UNUserNotificationCenter
            UNUserNotificationCenter.current().add(request) { error in
                if let error = error {
                    print("Error scheduling notification: \(error)")
                }
            }
        }
    }

    private func createTrigger(for schedule: RepeatSchedule, at time: Date) -> UNCalendarNotificationTrigger {
        var dateComponents = DateComponents()
        dateComponents.hour = Calendar.current.component(.hour, from: time)
        dateComponents.minute = Calendar.current.component(.minute, from: time)

        switch schedule {
        case .everyDay:
            // No additional components needed
            break
        case .everySunday:
            dateComponents.weekday = 1
        case .everyMonday:
            dateComponents.weekday = 2
        case .everyTuesday:
            dateComponents.weekday = 3
        case .everyWednesday:
            dateComponents.weekday = 4
        case .everyThursday:
            dateComponents.weekday = 5
        case .everyFriday:
            dateComponents.weekday = 6
        case .everySaturday:
            dateComponents.weekday = 7
//        default:
//            break
        }

        return UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
    }
}
