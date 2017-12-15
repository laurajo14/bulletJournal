//
//  WeeklyTaskTableViewCell.swift
//  bulletJournal
//
//  Created by Laura O'Brien on 12/14/17.
//  Copyright © 2017 Laura O'Brien. All rights reserved.
//

import UIKit

class WeeklyTaskTableViewCell: UITableViewCell {
    
    //MARK: - Outlets
    @IBOutlet weak var bulletButton: UIButton!
    @IBOutlet weak var taskTextField: UITextField!
    
    //MARK: - Properties
    var weeklyTaskEntries: WeeklyTaskEntry? {
        didSet {
            updateViews()
        }
    }
    
    //Actions
    func updateViews(){
        guard let weeklyTaskEntries = weeklyTaskEntries else { return }
        taskTextField.text = weeklyTaskEntries.name
        bulletButton.titleLabel?.text = weeklyTaskEntries.bulletType
    }
    
}

