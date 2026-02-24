//
//  TrackerStore.swift
//  Tracker
//
//  Created by Denis Bokov on 24.02.2026.
//

import Foundation
import CoreData

final class TrackerStore {
    private let context: NSManagedObjectContext
    
    convenience init() {
        let context = StorageManager.shared.persistentContainer.viewContext
        self.init(context: context)
    }
    
    init (context: NSManagedObjectContext) {
        self.context = context
    }
    
    func addNewTracker(_ tracker: Tracker) throws {
        let trackerObject = TrackerCoreData(context: context)
        trackerObject.id = tracker.id
        trackerObject.name = tracker.name
        trackerObject.color = tracker.color.rawValue
        trackerObject.emoji = tracker.emoji
        trackerObject.schedule = tracker.schedule as NSSet
        
        try context.save()
    }
}
