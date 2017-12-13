//
//  TaskEntry+Convenience.swift
//  bulletJournal
//
//  Created by Laura O'Brien on 12/6/17.
//  Copyright © 2017 Laura O'Brien. All rights reserved.
//

import Foundation
import CloudKit

class TaskEntry: Equatable {
    
    //MARK: - Properties
    var name: String
    var bulletType: String
    
    self.name = name
    self.bulletType = bulletType
    
    var recordID: CKRecordID
    
    init(name: String, bulletType: String) {
        self.name = name
        self.bulletType = bulletType
        self.recordID = CKRecordID(recordName: UUID().uuidString)
    }
    
    //MARK: cloudKit Record PUT
    var cloudKitRecord: CKRecord {
        let record = CKRecord(recordType: Keys.recordTaskEntryType, recordID: recordID)
        
        record.setValue(name, forKey: Keys.taskEntryNameKey, bulletType, forKey: Keys.taskEntryBulletTypeKey)
        
        return record
    }
    
    //MARK: - Failable initilaizer for CloudKit
    init?(cloudKitRecord: CKRecord){
        guard let name = cloudKitRecord[Keys.taskEntryNameKey] as? String,
        let bulletType = cloudKitRecord[Keys.taskEntryBulletTypeKey] as? String
            else { return nil }
        
        self.name = name
        self.bulletType = bulletType
        self.recordID = cloudKitRecord.recordID
    }
}

//MARK: - Equatable
func ==(lhs: TaskEntry, rhs: TaskEntry) -> Bool {
    return lhs.recordID == rhs.recordID
}
