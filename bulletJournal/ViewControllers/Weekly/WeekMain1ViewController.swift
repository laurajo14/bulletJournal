//
//  WeekMain1ViewController.swift
//  bulletJournal
//
//  Created by Laura O'Brien on 12/4/17.
//  Copyright © 2017 Laura O'Brien. All rights reserved.
//

import UIKit

class WeekMain1ViewController: UIViewController, UITextViewDelegate {
    
    //MARK: - Outlets
    @IBOutlet weak var sideMenuWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var monthlyVisionLabel: UILabel!
    @IBOutlet weak var weeklyGoalsTextView: UITextView!
    @IBOutlet weak var weeklyPlansTextView: UITextView!
    
    //MARK: - Properties
    var isSlideMenuHidden = true
    var weeklyEntry: WeeklyEntry? {
        didSet {
            if isViewLoaded { updateViews() }
        }
    }
    
    //MARK: - View Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        sideMenuWidthConstraint.constant = 0
        updateViews()
    }
    
    override func viewDidDisappear(_ animated: Bool){
        super.viewDidDisappear(false)
        sideMenuWidthConstraint.constant = 0
    }
    
    //MARK: - Actions
    @IBAction func menuButtonTapped(_ sender: UIBarButtonItem) {
        if isSlideMenuHidden {
            sideMenuWidthConstraint.constant = 180
            UIView.animate(withDuration: 0.3, animations: {
                self.view.layoutIfNeeded()
            })
        } else {
            sideMenuWidthConstraint.constant = 0
            UIView.animate(withDuration: 0.3, animations: {
                self.view.layoutIfNeeded()
            })
        }
        isSlideMenuHidden = !isSlideMenuHidden
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let weeklyGoalEntry = weeklyGoalsTextView.text, let weeklyPlanEntry = weeklyPlansTextView.text else { return }
        if let weeklyEntry = self.weeklyEntry {
            WeeklyEntryController.shared.updateWeeklyEntryWith(weeklyEntry: weeklyEntry, weeklyGoalEntry: weeklyGoalEntry, weeklyPlanEntry: weeklyPlanEntry, weeklyReviewEntry: "", weeklyJournalEntry: "")
        } else {
            WeeklyEntryController.shared.createWeeklyEntryWith(weeklyGoalEntry: weeklyGoalEntry, weeklyPlanEntry: weeklyPlanEntry, weeklyReviewEntry: "", weeklyJournalEntry: "")
        }
        let _ = self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: FUNCTIONS
    private func updateViews() {
        guard let weeklyEntry = weeklyEntry else { return }
        weeklyGoalsTextView.text = weeklyEntry.weeklyGoalEntry
        weeklyPlansTextView.text = weeklyEntry.weeklyPlanEntry
    }
    
    // MARK: UITextViewDelegate
    func textViewShouldReturn(_ textField: UITextField) -> Bool {
        
        weeklyGoalsTextView.resignFirstResponder()
        weeklyPlansTextView.resignFirstResponder()
        
        return true
    }
//    func textViewDidEndEditing(_ textView: UITextView) {
//        if textView == weeklyGoalsTextView {
//            let weeklyGoalEntry = weeklyGoalsTextView.text
//            if let weeklyEntry = self.weeklyEntry {
//                WeeklyEntryController.shared.updateWeeklyEntryWith(weeklyEntry: weeklyEntry, weeklyGoalEntry: weeklyGoalEntry!, weeklyPlanEntry: "", weeklyReviewEntry: "", weeklyJournalEntry: "")
//            } else {
//                WeeklyEntryController.shared.createWeeklyEntryWith(weeklyGoalEntry: weeklyGoalEntry!, weeklyPlanEntry: "", weeklyReviewEntry: "", weeklyJournalEntry: "")
//            }
//        } else {
//            let weeklyPlanEntry = weeklyPlansTextView.text
//            if let weeklyEntry = self.weeklyEntry {
//                WeeklyEntryController.shared.updateWeeklyEntryWith(weeklyEntry: weeklyEntry, weeklyGoalEntry: "", weeklyPlanEntry: weeklyPlanEntry!, weeklyReviewEntry: "", weeklyJournalEntry: "")
//            } else {
//                WeeklyEntryController.shared.createWeeklyEntryWith(weeklyGoalEntry: "", weeklyPlanEntry: weeklyPlanEntry!, weeklyReviewEntry: "", weeklyJournalEntry: "")
//            }
//        }
//    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
