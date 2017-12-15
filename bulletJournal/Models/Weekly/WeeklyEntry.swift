//
//  WeeklyEntry.swift
//  bulletJournal
//
//  Created by Laura O'Brien on 12/14/17.
//  Copyright © 2017 Laura O'Brien. All rights reserved.
//

import Foundation
import UIKit
import CloudKit

class WeeklyEntry: Equatable {
    
    //MARK: - Properties
    var weeklyGoalEntry: String
    var weeklyPlanEntry: String
    var weeklyReviewEntry: String
    var weeklyJournalEntry: String

    var recordID: CKRecordID
    
//    static let recordWeeklyEntryType = "WeeklyEntry"
//
//    static let weeklyGoalEntryKey = "weeklyGoalEntry"
//    static let weeklyPlanEntryKey = "weeklyPlanEntry"
//    static let weeklyReviewEntryKey = "weeklyReviewEntry"
//    static let weeklyJournalEntryKey = "weeklyJournalEntry"
//
    init(weeklyGoalEntry: String, weeklyPlanEntry: String, weeklyReviewEntry: String, weeklyJournalEntry: String){
        self.weeklyGoalEntry = weeklyGoalEntry
        self.weeklyPlanEntry = weeklyPlanEntry
        self.weeklyReviewEntry = weeklyReviewEntry
        self.weeklyJournalEntry = weeklyJournalEntry
        
        self.recordID = CKRecordID(recordName: UUID().uuidString)
    }
    
    //MARK: cloudKit Record PUT
    var cloudKitRecord: CKRecord {
        let record = CKRecord(recordType: Keys.recordWeeklyEntryType, recordID: recordID)
        
        record.setValue(weeklyGoalEntry, forKey: Keys.weeklyGoalEntryKey)
        record.setValue(weeklyPlanEntry, forKey: Keys.weeklyPlanEntryKey)
        record.setValue(weeklyReviewEntry, forKey: Keys.weeklyReviewEntryKey)
        record.setValue(weeklyJournalEntry, forKey: Keys.weeklyJournalEntryKey)
        
        return record
    }
    
    //MARK: - Failable initilaizer for CloudKit
    init?(cloudKitRecord: CKRecord){
        guard let weeklyGoalEntry = cloudKitRecord[Keys.weeklyGoalEntryKey] as? String,
        let weeklyPlanEntry = cloudKitRecord[Keys.weeklyPlanEntryKey] as? String,
        let weeklyReviewEntry = cloudKitRecord[Keys.weeklyReviewEntryKey] as? String,
        let weeklyJournalEntry = cloudKitRecord[Keys.weeklyJournalEntryKey] as? String
            else { return nil }
        
        self.weeklyGoalEntry = weeklyGoalEntry
        self.weeklyPlanEntry = weeklyPlanEntry
        self.weeklyReviewEntry = weeklyReviewEntry
        self.weeklyJournalEntry = weeklyJournalEntry
        
        self.recordID = cloudKitRecord.recordID
    }
}

//MARK: - Equatable
func ==(lhs: WeeklyEntry, rhs: WeeklyEntry) -> Bool {
    return lhs.recordID == rhs.recordID
}
