//
//  ScheduledEventEntry.swift
//  bulletJournal
//
//  Created by Laura O'Brien on 12/7/17.
//  Copyright © 2017 Laura O'Brien. All rights reserved.
//

import Foundation
import CloudKit

class DailyScheduleEntry: Equatable {
    
    //MARK: - Properties
    var name: String
    var recordID: CKRecordID
    
    init(name: String) {
        self.name = name
        self.recordID = CKRecordID(recordName: UUID().uuidString)
    }
    
    //MARK: cloudKit Record PUT
    var cloudKitRecord: CKRecord {
        let record = CKRecord(recordType: Keys.recordDailyScheduleEntryType, recordID: recordID)
        
        record.setValue(name, forKey: Keys.dailyScheduleNameKey)
        
        return record
    }
    
    //MARK: - Failable initilaizer for CloudKit
    init?(cloudKitRecord: CKRecord){
        guard let name = cloudKitRecord[Keys.dailyScheduleNameKey] as? String
            else { return nil }
        
        self.name = name
        self.recordID = cloudKitRecord.recordID
    }
}

//MARK: - Equatable
func ==(lhs: DailyScheduleEntry, rhs: DailyScheduleEntry) -> Bool {
    return lhs.recordID == rhs.recordID
}

