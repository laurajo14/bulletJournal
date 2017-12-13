//
//  MonthlyTaskEntry+Convenience.swift
//  bulletJournal
//
//  Created by Laura O'Brien on 12/9/17.
//  Copyright © 2017 Laura O'Brien. All rights reserved.
//

import Foundation
import CloudKit

class MonthlyTaskEntry: Equatable {
    
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
        let record = CKRecord(recordType: Keys.recordMonthlyTaskEntryType, recordID: recordID)

        record.setValue(name, forKey: Keys.monthlyTaskNameKey)
        record.setValue(bulletType, forKey: Keys.monthlyTaskBulletTypeKey)
        
        return record
    }
    
    //MARK: - Failable initilaizer for CloudKit
    init?(cloudKitRecord: CKRecord){
        guard let name = cloudKitRecord[Keys.monthlyTaskNameKey] as? String,
        let bulletType = cloudKitRecord[Keys.monthlyTaskBulletTypeKey] as? String
            else { return nil }
        
        self.name = name
        self.bulletType = bulletType
        self.recordID = cloudKitRecord.recordID
    }
}

//MARK: - Equatable
func ==(lhs: MonthlyTaskEntry, rhs: MonthlyTaskEntry) -> Bool {
    return lhs.recordID == rhs.recordID
}
