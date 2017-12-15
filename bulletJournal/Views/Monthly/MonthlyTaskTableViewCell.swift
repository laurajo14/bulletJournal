//
//  MonthlyTaskTableViewCell.swift
//  bulletJournal
//
//  Created by Laura O'Brien on 12/8/17.
//  Copyright © 2017 Laura O'Brien. All rights reserved.
//

import UIKit

class MonthlyTaskTableViewCell: UITableViewCell {

    //MARK: - Outlets
    @IBOutlet weak var bulletButton: UIButton!
    @IBOutlet weak var taskTextView: UITextView!

    //MARK: - Properties
    var monthlyTaskEntries: MonthlyTaskEntry? {
        didSet {
            updateViews()
        }
    }
    
    //Actions
    func updateViews(){
        guard let monthlyTaskEntries = monthlyTaskEntries else { return }
        taskTextView.text = monthlyTaskEntries.name
        bulletButton.titleLabel?.text = monthlyTaskEntries.bulletType
    }
    
}
