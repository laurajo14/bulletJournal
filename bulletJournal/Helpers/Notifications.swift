//
//  Notifications.swift
//  bulletJournal
//
//  Created by Laura O'Brien on 12/13/17.
//  Copyright © 2017 Laura O'Brien. All rights reserved.
//

import Foundation

// MARK: - Notification for PageView ViewControllers

struct Notifications {
    
    //Daily
    static let dailyScheduleEntryWasUpdatedNotification = Notification.Name("dailyScheduleEntryWasUpdated")
    static let thoughtEntryWasUpdatedNotification = Notification.Name("thoughtEntryWasUpdated")
    static let eventEntryWasUpdatedNotification = Notification.Name("eventEntryWasUpdated")
    static let taskEntryWasUpdatedNotification = Notification.Name("taskEntryWasUpdated")

    //Weekly
    static let weeklyTaskWasUpdatedNotification = Notification.Name("weeklyTaskWasUpdated")
    static let weeklyEntryWasUpdatedNotification = Notification.Name("weeklyEntryWasUpdated")
    
    //Monthly
    static let monthlyTaskWasUpdatedNotification = Notification.Name("monthlyTaskWasUpdated")
    
    //Yearly
    
    
}
