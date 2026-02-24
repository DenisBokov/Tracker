//
//  TrackerCategoryStore.swift
//  Tracker
//
//  Created by Denis Bokov on 24.02.2026.
//

import Foundation
import CoreData

final class TrackerCategoryStore {
    private let context: NSManagedObjectContext
    
    convenience init() {
        let context = StorageManager.shared.persistentContainer.viewContext
        self.init(context: context)
    }
    
    init (context: NSManagedObjectContext) {
        self.context = context
    }
    
    func addNewTrackerCategory(_ trackerCategory: TrackerCategory) throws {
        let categoryObject = TrackerCategoryCoreData(context: context)
        categoryObject.heading = trackerCategory.heading
        
        for tracker in trackerCategory.trackers {
            let trackerObject = TrackerCoreData(context: context)
            trackerObject.id = tracker.id
            trackerObject.name = tracker.name
            trackerObject.emoji = tracker.emoji
            trackerObject.color = tracker.color.rawValue
            
            categoryObject.addToTrackers(trackerObject)
        }
        
        try context.save()
    }
}
