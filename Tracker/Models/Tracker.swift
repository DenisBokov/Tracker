//
//  Tracker.swift
//  Tracker
//
//  Created by Denis Bokov on 24.01.2026.
//

import Foundation

//enum TrackerColor: String {
//    case red
//    case blue
//    case green = "SectionColorGreen"
//}

enum TrackerColor: String, CaseIterable, Codable {

    case trackerBlue
    case trackerBluePurple
    case trackerCoral
    case trackerDarkOrange
    case trackerDarkPurple
    case trackerGreen
    case trackerLightBlue
    case trackerLightGreen
    case trackerLightOrange
    case trackerLightPink
    case trackerLilac
    case trackerLimeGreen
    case trackerOrange
    case trackerOrchid
    case trackerPink
    case trackerSlateBlue
    case trackerViolet
    case trackerRed
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

