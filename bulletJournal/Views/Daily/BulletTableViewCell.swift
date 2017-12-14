//
//  BulletTableViewCell.swift
//  bulletJournal
//
//  Created by Laura O'Brien on 12/5/17.
//  Copyright © 2017 Laura O'Brien. All rights reserved.
//

import UIKit

protocol BulletTableViewCellDelegate: class {    
}

class BulletTableViewCell: UITableViewCell {

    //MARK: - Outlets
    @IBOutlet weak var bulletButton: UIButton!
    @IBOutlet weak var noteTextView: UITextView!
    
    //MARK: - Actions
    
    
    //MARK: - Properties
    //    var bulletTypes = ["●", "x", ">>"]
    //    var bulletTypes = ["1", "2", "3"]

    var thoughtEntry: ThoughtEntry? {
        didSet {
            updateThoughtEntryViews()
        }
    }
    
    var eventEntry: ThoughtEntry? {
        didSet {
            updateEventEntryViews()
        }
    }
    
    var taskEntry: TaskEntry?
    
    
    weak var delegate: BulletTableViewCellDelegate?
    
    //Actions
    func updateThoughtEntryViews(){
        guard let thoughtEntry = thoughtEntry else { return }
        noteTextView.text = thoughtEntry.name
        bulletButton.titleLabel?.text = "-"
    }
    
    func updateEventEntryViews(){
        guard let eventEntry = eventEntry else { return }
        noteTextView.text = eventEntry.name
        bulletButton.titleLabel?.text = "○"
    }
    
    
    
    
    
///>>setting task bullet status as normal, complete, or migrate
//        if taskEntry.normalStatus == true {
//            statusButton.setImage(#imageLiteral(resourceName: "complete"), for: .normal)
//        } else if {
//            statusButton.setImage(#imageLiteral(resourceName: "incomplete"), for: .normal)
//        } else {
//
//        }

///if the status button is migrated, set up an alert to ask what date to move the task to
//    @IBAction func isCompleteButtonTapped(_ sender: Any) {
//        delegate?.itemTableViewCellCompleteButtonTapped(self)
//    }
    
}
