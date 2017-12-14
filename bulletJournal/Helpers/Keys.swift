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
    static let recordWeeklyEntryType = "WeeklyEntry"

    static let weeklyGoalEntryKey = "weeklyGoalEntry"
    static let weeklyPlanEntryKey = "weeklyPlanEntry"
    static let weeklyReviewEntryKey = "weeklyReviewEntry"
    static let weeklyJournalEntryKey = "weeklyJournalEntry"
    
    //weeklyEventEntry Model Keys
    static let recordWeeklyEventEntryType = "WeeklyEventEntry"
    static let weeklyEventEntryNameKey = "name"

    //weeklyTaskEntry Model Keys
    static let recordWeeklyTaskEntryType = "WeeklyTaskEntry"
    static let taskWeeklyEntryNameKey = "name"
    static let taskWeeklyEntryBulletTypeKey = "bulletType"
    
    
    ///MARK: - MONTHLY MODELS
    //monthlyEntry Model Keys
    static let recordMonthlyEntryType = "MonthlyEntry"
    
    static let monthlyVisionEntryKey = "monthlyVisionEntry"
    static let monthlyGoalEntryKey = "monthlyGoalEntry"
    static let monthlyReviewEntryKey = "monthlyReviewEntry"
    static let monthlyJournalEntryKey = "monthlyJournalEntry"
    
    //monthlyTaskEntry Model Keys
    static let recordMonthlyTaskEntryType = "monthlyTaskEntry"
    static let monthlyTaskNameKey = "name"
    static let monthlyTaskBulletTypeKey = "bulletType"
    
    ///MARK: YEARLY MODELS
    //yearlyEntry Model Keys
    static let recordYearlyEntryType = "YearlyEntry"

    static let yearlyResolvesKey = "yearlyResolves"
    static let yearlyReviewEntryKey = "yearlyReviewEntry"
    static let yearlyJournalEntryKey = "yearlyJournalEntry"
}
