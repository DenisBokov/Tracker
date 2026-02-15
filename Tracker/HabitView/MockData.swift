//
//  MockData.swift
//  Tracker
//
//  Created by Denis Bokov on 06.02.2026.
//

import Foundation

enum MockData {
    static func makeTracker(schedule: Set<Weekday>) -> Tracker {
        Tracker(
            id: UUID(),
            name: "Полить растение",
            color: TrackerColor.trackerGreen,
            emoji: "😪",
            schedule: schedule
        )
    }
}
