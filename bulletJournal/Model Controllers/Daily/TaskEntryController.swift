//
//  TaskEntryController.swift
//  bulletJournal
//
//  Created by Laura O'Brien on 12/6/17.
//  Copyright © 2017 Laura O'Brien. All rights reserved.
//

import Foundation
import CloudKit

class TaskEntryController {
    
    static let shared = TaskEntryController()
    
    //MARK: - Properties
    let cloudKitManager: CloudKitManager
    let privateDatabase = CKContainer.default().privateCloudDatabase
    
    //MARK: - Source of Truth
    var taskEntries: [TaskEntry] = [] {
        didSet {
            NotificationCenter.default.post(name: Notifications.taskEntryWasUpdatedNotification, object: nil)
        }
    }
    
    init() {
        self.cloudKitManager = CloudKitManager()
    }
    
    //MARK: - Functions
    //CREATE
    func createTaskEntryWith(name: String, bulletType: String) {
        TaskEntry(name: name, bulletType: bulletType)
        
        let taskEntry = TaskEntry(name: name, bulletType: bulletType)
        taskEntries.append(taskEntry)
        
        cloudKitManager.saveRecord(taskEntry.cloudKitRecord) { (record, error) in
            
            if let error = error {
                print("Error saving Monthly Task Entry to cloudKit: \(error.localizedDescription) in file: \(#file)")
                return
            }
            return
        }
    }
    
    //UPDATE
    func updateTaskEntryWith(taskEntry: TaskEntry, name: String, bulletType: String, completion: @escaping (TaskEntry?) -> Void) {
        
        taskEntry.name = name
        taskEntry.bulletType = bulletType
        
        cloudKitManager.modifyRecords([taskEntry.cloudKitRecord], perRecordCompletion: nil) { (records, error) in
            
            if let error = error {
                print("Error saving new Task Entry: \(error.localizedDescription) in file: \(#file)")
                completion(nil)
                return
            }
            
            // Update the first Account
            guard let record = records?.first else {return}
            let updatedTaskEntry = TaskEntry(cloudKitRecord: record)
            completion(updatedTaskEntry)
        }
        
    }
    
    //DELETE
    func delete(taskEntry: TaskEntry) {
        
        cloudKitManager.deleteRecordWithID(taskEntry.recordID) { (recordID, error) in
            
            if let error = error {
                print("Error deleting Task Entry: \(error.localizedDescription) in file: \(#file)")
                return
            }
        }
    }
    
    // MARK: - Fetch Data from CloudKit
    func fetchTaskEntriesFromCloudKit() {
        
        // Get all of the accounts
        let predicate = NSPredicate(value: true)
        
        // Create a query
        let query = CKQuery(recordType: Keys.recordTaskEntryType, predicate: predicate)
        
        // Fetch the data form cloudkit
        privateDatabase.perform(query, inZoneWith: nil) { (records, error) in
            
            // Check for an errror
            if let error = error {
                print("Error fetching the Task Entries Data: \(error.localizedDescription) in file: \(#file)")
            }
            
            guard let records = records else {return}
            
            // Send the accounts through the cloudKit Initializer
            let taskEntry = records.flatMap( {TaskEntry(cloudKitRecord: $0)})
            
            self.taskEntries = taskEntry
        }
    }
}
