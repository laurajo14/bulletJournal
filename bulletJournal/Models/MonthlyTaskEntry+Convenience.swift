//
//  MonthlyTaskEntry+Convenience.swift
//  bulletJournal
//
//  Created by Laura O'Brien on 12/9/17.
//  Copyright © 2017 Laura O'Brien. All rights reserved.
//

import Foundation
import CoreData

extension MonthlyTaskEntry {
    @discardableResult convenience init (name: String, bulletType: String, context: NSManagedObjectContext = CoreDataStack.context) {
        
        self.init(context: context)
        
        self.name = name
        self.bulletType = bulletType
        
    }
}
