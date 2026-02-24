//
//  TrackerRecordStore.swift
//  Tracker
//
//  Created by Denis Bokov on 24.02.2026.
//

import Foundation
import CoreData

final class TrackerRecordStore {
    private let context: NSManagedObjectContext
    
    convenience init() {
        let context = StorageManager.shared.persistentContainer.viewContext
        self.init(context: context)
    }
    
    init (context: NSManagedObjectContext) {
        self.context = context
    }
    
    func addNewTrackerRecord(_ trackerRecord: TrackerRecord) throws {
        let trackerRecordObject = TrackerRecordCoreData(context: context)
        trackerRecordObject.trackerId = trackerRecord.trackerId
        trackerRecordObject.date = trackerRecord.date
        
        try context.save()
    }
}
