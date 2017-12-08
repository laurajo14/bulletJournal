//
//  EventTableViewCell.swift
//  bulletJournal
//
//  Created by Laura O'Brien on 12/5/17.
//  Copyright © 2017 Laura O'Brien. All rights reserved.
//

import UIKit

protocol DailyScheduleTableViewCellDelegate: class {
    
    func DailyScheduleTableViewCellTextFieldDidEndEditing(_ cell: DailyScheduleTableViewCell)
}

class DailyScheduleTableViewCell: UITableViewCell {
    
    //MARK: - Outlets
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var dailyScheduleEntryTF: UITextField!
    
    
    //MARK: - Properties
    var dailyScheduleEntry: DailyScheduleEntry? {
        didSet {
            updateViews()
        }
    }
    
    weak var delegate: DailyScheduleTableViewCellDelegate?
    
    //MARK: - Actions
    @IBAction func textFieldDidEndEditing(_ sender: Any) {
        delegate?.DailyScheduleTableViewCellTextFieldDidEndEditing(self)
    }
    
    //MARK: - Functions
    func updateViews(){
        guard let dailyScheduleEntry = dailyScheduleEntry else { return }
    }
    
    
}
