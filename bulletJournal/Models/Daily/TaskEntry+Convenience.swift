//
//  TaskEntry+Convenience.swift
//  bulletJournal
//
//  Created by Laura O'Brien on 12/6/17.
//  Copyright © 2017 Laura O'Brien. All rights reserved.
//

import Foundation
import CoreData

extension TaskEntry {
    @discardableResult convenience init (name: String, context: NSManagedObjectContext = CoreDataStack.context) {
        
        self.init(context: context)
        
        self.name = name
    }
}
