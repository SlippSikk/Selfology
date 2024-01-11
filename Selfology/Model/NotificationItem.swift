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
    var time: String
    var taskName: String
    var description: String
}
