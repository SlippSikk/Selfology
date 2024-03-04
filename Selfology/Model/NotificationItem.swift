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
    case everyDay = "EVERY DAY"
    case everyMonday = "EVERY MONDAY"
    case everyTuesday = "EVERY TUESDAY"
    case everyWednesday = "EVERY WEDNESDAY"
    case everyThursday = "EVERY THURSDAY"
    case everyFriday = "EVERY FRIDAY"
    case everySaturday = "EVERY SATURDAY"
    case everySunday = "EVERY SUNDAY"
}



