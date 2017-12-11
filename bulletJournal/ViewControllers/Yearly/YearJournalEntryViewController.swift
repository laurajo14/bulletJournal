//
//  YearJournalEntryViewController.swift
//  bulletJournal
//
//  Created by Laura O'Brien on 12/4/17.
//  Copyright © 2017 Laura O'Brien. All rights reserved.
//

import UIKit

class YearJournalEntryViewController: UIViewController {

    //MARK: - Outlets
    @IBOutlet weak var yearLabel: UILabel!

    //MARK: - View Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpYearLabel()
    }
    
    //MARK: - Year Label Function
    func setUpYearLabel() {
        let currentDate = Date(timeInterval: 0, since: Date())
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy"
        let thisYear = formatter.string(from: currentDate)
        yearLabel.text = "\(thisYear)"
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
