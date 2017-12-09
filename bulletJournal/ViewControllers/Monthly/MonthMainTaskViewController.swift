//
//  MonthMainTaskViewController.swift
//  bulletJournal
//
//  Created by Laura O'Brien on 12/8/17.
//  Copyright © 2017 Laura O'Brien. All rights reserved.
//

import UIKit

class MonthMainTaskViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    //MARK: - Properties
    var isSlideMenuHidden = true
    
    //MARK: - Outlets
    @IBOutlet weak var sideMenuWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var tableView: UITableView!
 
    
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
    
    //MARK: - TableViewFunctions
    func setUpDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    
    //MARK: - View Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpDelegates()
        sideMenuWidthConstraint.constant = 0
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        self.tableView.reloadData()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(false)
        sideMenuWidthConstraint.constant = 0
    }
    
    //MARK: - TableView Data Source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "monthlyTaskCell", for: indexPath) as? MonthlyTaskTableViewCell else { return UITableViewCell() }
        
        return cell
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
