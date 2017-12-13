//
//  MonthIndexViewController.swift
//  bulletJournal
//
//  Created by Laura O'Brien on 12/4/17.
//  Copyright © 2017 Laura O'Brien. All rights reserved.
//

import UIKit

class YearIndexViewController: UIViewController {    

    //MARK: - Outlets
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var sideMenuWidthConstraint: NSLayoutConstraint!
    
    //MARK: - Properties
    var isSlideMenuHidden = true
    
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
    
    //MARK: - View Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpYearLabel()
        sideMenuWidthConstraint.constant = 0
    }

    override func viewDidDisappear(_ animated: Bool){
        super.viewDidDisappear(false)
        sideMenuWidthConstraint.constant = 0
    }
    
    //MARK: - Year Label
    func setUpYearLabel() {
        let currentDate = Date(timeInterval: 0, since: Date())
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy"
        let today = formatter.string(from: currentDate)
        yearLabel.text = "\(today)"
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
