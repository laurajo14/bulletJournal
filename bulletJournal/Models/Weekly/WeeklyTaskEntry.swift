//
//  WeeklyTaskEntry.swift
//  bulletJournal
//
//  Created by Laura O'Brien on 12/14/17.
//  Copyright © 2017 Laura O'Brien. All rights reserved.
//

import Foundation
import UIKit
import CloudKit

class WeeklyTaskEntry: Equatable {
    
    //MARK: - Properties
    var name: String
    var bulletType: String
    var recordID: CKRecordID
    
    init(name: String, bulletType: String) {
        self.name = name
        self.bulletType = bulletType
        self.recordID = CKRecordID(recordName: UUID().uuidString)
    }
    
    //MARK: cloudKit Record PUT
    var cloudKitRecord: CKRecord {
        let record = CKRecord(recordType: Keys.recordWeeklyTaskEntryType, recordID: recordID)
        
        record.setValue(name, forKey: Keys.weeklyTaskEntryNameKey)
        record.setValue(bulletType, forKey: Keys.weeklyTaskEntryBulletTypeKey)
        
        return record
    }
    
    //MARK: - Failable initilaizer for CloudKit
    init?(cloudKitRecord: CKRecord){
        guard let name = cloudKitRecord[Keys.weeklyTaskEntryNameKey] as? String,
            let bulletType = cloudKitRecord[Keys.weeklyTaskEntryBulletTypeKey] as? String
            else { return nil }
        
        self.name = name
        self.bulletType = bulletType
        self.recordID = cloudKitRecord.recordID
    }
}

//MARK: - Equatable
func ==(lhs: WeeklyTaskEntry, rhs: WeeklyTaskEntry) -> Bool {
    return lhs.recordID == rhs.recordID
}
