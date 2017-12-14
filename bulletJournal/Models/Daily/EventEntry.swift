//
//  EventEntry+Convenience.swift
//  bulletJournal
//
//  Created by Laura O'Brien on 12/6/17.
//  Copyright © 2017 Laura O'Brien. All rights reserved.
//

import Foundation
import CloudKit

class EventEntry: Equatable {
    
    //MARK: - Properties
    var name: String
    var recordID: CKRecordID
    
    init(name: String) {
        self.name = name
        self.recordID = CKRecordID(recordName: UUID().uuidString)
    }
    
    //MARK: cloudKit Record PUT
    var cloudKitRecord: CKRecord {
        let record = CKRecord(recordType: Keys.recordEventEntryType, recordID: recordID)
        
        record.setValue(name, forKey: Keys.eventEntryNameKey)
        
        return record
    }
    
    //MARK: - Failable initilaizer for CloudKit
    init?(cloudKitRecord: CKRecord){
        guard let name = cloudKitRecord[Keys.eventEntryNameKey] as? String
            else { return nil }
        
        self.name = name
        self.recordID = cloudKitRecord.recordID
    }
}

//MARK: - Equatable
func ==(lhs: EventEntry, rhs: EventEntry) -> Bool {
    return lhs.recordID == rhs.recordID
}
