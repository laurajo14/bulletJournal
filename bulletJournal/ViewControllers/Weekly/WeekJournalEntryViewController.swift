//
//  WeekJournalEntryViewController.swift
//  bulletJournal
//
//  Created by Laura O'Brien on 12/4/17.
//  Copyright © 2017 Laura O'Brien. All rights reserved.
//

import UIKit

class WeekJournalEntryViewController: UIViewController {

    //MARK: - Outlets
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var pageController: UIPageControl!
    @IBOutlet weak var textView: UITextView!
    
    //MARK: - Actions
    @IBAction func pageControllerSwiped(_ sender: Any) {
    }
    
    //MARK: - View Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
//        textView.layer.borderWidth = 1
//        textView.layer.cornerRadius = 8
//        textView.layer.borderColor = UIColor.darkGray as! CGColor
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
