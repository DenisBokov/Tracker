//
//  Tracker.swift
//  Tracker
//
//  Created by Denis Bokov on 24.01.2026.
//

import Foundation

enum TrackerColor: String {
    case red
    case blue
    case green
}

enum Weekday: Int, CaseIterable {
    case monday, tuesdays, wednesday, thursday, friday, saturday, sunday
}

struct Tracker {
    let id: UUID
    let name: String
    let color: TrackerColor
    let emoji: String
    let schedule: Set<Weekday>
}

