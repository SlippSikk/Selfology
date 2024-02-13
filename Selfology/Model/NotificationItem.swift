//
//  NotificationItem.swift
//  Selfology
//
//  Created by Hamed BAQAIE on 11/1/2024.
//

import Foundation

struct NotificationItem: Identifiable, Codable {
    var id: UUID = UUID()
    var isOn: Bool
    var time: Date
    var taskName: String
    var description: String
//    var repeatSchedule: RepeatSchedule
}


enum RepeatSchedule: String, Codable, CaseIterable {
    case everyDay = "Every Day"
    case everyMonday = "Every Monday"
    case everyTuesday = "Every Tuesday"
    case everyWednesday = "Every Wednesday"
    case everyThursday = "Every Thursday"
    case everyFriday = "Every Friday"
    case everySaturday = "Every Saturday"
    case everySunday = "Every Sunday"
}
