//
//  WeekReviewViewController.swift
//  bulletJournal
//
//  Created by Laura O'Brien on 12/4/17.
//  Copyright © 2017 Laura O'Brien. All rights reserved.
//

import UIKit

class WeekReviewViewController: UIViewController {

    //MARK: - Properties
    var isSlideMenuHidden = true
    
    //MARK: - Outlets
    @IBOutlet weak var sideMenuWidthConstraint: NSLayoutConstraint!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sideMenuWidthConstraint.constant = 0
    }

    override func viewDidDisappear(_ animated: Bool){
        super.viewDidDisappear(false)
        sideMenuWidthConstraint.constant = 0
    }
    
    //MARK: - Actions
    @IBAction func menuButtonTapped(_ sender: UIBarButtonItem) {
        if isSlideMenuHidden {
            //          sideMenuConstraint.constant = 0
            sideMenuWidthConstraint.constant = 180
            UIView.animate(withDuration: 0.3, animations: {
                self.view.layoutIfNeeded()
            })
        } else {
            //            sideMenuConstraint.constant = -180
            sideMenuWidthConstraint.constant = 0
            
            UIView.animate(withDuration: 0.3, animations: {
                self.view.layoutIfNeeded()
            })
        }
        isSlideMenuHidden = !isSlideMenuHidden
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
