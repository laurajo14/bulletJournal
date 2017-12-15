//
//  BulletTableViewCell.swift
//  bulletJournal
//
//  Created by Laura O'Brien on 12/5/17.
//  Copyright © 2017 Laura O'Brien. All rights reserved.
//

import UIKit

protocol BulletTableViewCellDelegate: class {
    func bulletTableViewCellnoteTFDidEndEditing(_ cell: BulletTableViewCell)
}

class BulletTableViewCell: UITableViewCell {

    //MARK: - Outlets
    @IBOutlet weak var bulletButton: UIButton!
    @IBOutlet weak var noteTextField: UITextField!
    
    //MARK: - Properties
    var thoughtEntries: ThoughtEntry? {
        didSet {
            updateThoughtEntryViews()
        }
    }
    
    var eventEntries: EventEntry? {
        didSet {
            updateEventEntryViews()
        }
    }
    
    var taskEntries: TaskEntry?
    
    weak var delegate: BulletTableViewCellDelegate?
    
    //MARK: - Actions
    func updateThoughtEntryViews(){
        guard let thoughtEntry = thoughtEntries else { return }
        noteTextField.text = thoughtEntry.name
        bulletButton.titleLabel?.text = "-"
    }
    
    func updateEventEntryViews(){
        guard let eventEntry = eventEntries else { return }
        noteTextField.text = eventEntry.name
        bulletButton.titleLabel?.text = "○"
    }
    
    @IBAction func bulletCellDidEndEditing(_ sender: UITextField) {
        delegate?.bulletTableViewCellnoteTFDidEndEditing(self)
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
