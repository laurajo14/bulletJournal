//
//  Keys.swift
//  bulletJournal
//
//  Created by Laura O'Brien on 12/13/17.
//  Copyright © 2017 Laura O'Brien. All rights reserved.
//

import Foundation

struct Keys {

    ///MARK: - DAILY MODELS
    //dailyScheduleEntry Model Keys
    static let recordDailyScheduleEntryType = "dailyScheduleEntry"
    static let dailyScheduleNameKey = "name"

    //thoughtEntry Model Keys
    static let recordThoughtEntryType = "ThoughtEntry"
    static let thoughtEntryNameKey = "name"
    
    //eventEntry Model Keys
    static let recordEventEntryType = "EventEntry"
    static let eventEntryNameKey = "name"

    //taskEntry Model Keys
    static let recordTaskEntryType = "TaskEntry"
    static let taskEntryNameKey = "name"
    static let taskEntryBulletTypeKey = "bulletType"

    ///MARK: - WEEKLY MODELS
    //weeklyEntry Model Keys
    var goals: String
    var plans: String
    var weeklyReviewEntry: String
    var weeklyJournalEntry: String
    
    //weeklyEventEntry Model Keys
    
    //weeklyTaskEntry Model Keys

    
    ///MARK: - MONTHLY MODELS
    //monthlyEntry Model Keys
    var monthlyVision: String
    var monthlyGoals: String
    var monthlyReviewEntry: String
    var monthlyJournalEntry: String
    
    //monthlyTaskEntry Model Keys
    static let recordMonthlyTaskEntryType = "monthlyTaskEntry"
    static let monthlyTaskNameKey = "name"
    static let monthlyTaskBulletTypeKey = "bulletType"
    
    ///MARK: YEARLY MODELS
    //yearlyEntry Model Keys
    var yearlyResolves: String
    var yearlyReviewEntry: String
    var yearlyJournalEntry: String
}
