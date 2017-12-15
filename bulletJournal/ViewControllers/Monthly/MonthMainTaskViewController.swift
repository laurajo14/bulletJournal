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
    @IBAction func addButtonTapped(_ sender: UIButton) {
        setUpAlertController()
    }
    
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
        NotificationCenter.default.addObserver(self, selector: #selector(reloadTableView), name: Notifications.monthlyTaskWasUpdatedNotification, object: nil)
        tableView.reloadData()
        setUpTableView()
        sideMenuWidthConstraint.constant = 0
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        setUpTableView()
        self.tableView.reloadData()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(false)
        sideMenuWidthConstraint.constant = 0
    }
    
    @objc func reloadTableView() {
        DispatchQueue.main.async {
            self.setUpTableView()
        }
    }
    
    //MARK: - UI SetUp
    /// This function is run when the view first loads
    func setUpTableView() {
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    //MARK: - TableView Data Source
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let monthlyTaskEntries = MonthlyTaskEntryController.shared.monthlyTaskEntries.count
        return (monthlyTaskEntries > 0) ? monthlyTaskEntries : 0
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "monthlyTaskCell", for: indexPath) as? MonthlyTaskTableViewCell else {
            return UITableViewCell ()
            
        }

        let monthlyTaskEntry = MonthlyTaskEntryController.shared.monthlyTaskEntries[indexPath.row]
        cell.monthlyTaskEntries = monthlyTaskEntry
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            let monthlyTaskEntry = MonthlyTaskEntryController.shared.monthlyTaskEntries[indexPath.row]
            MonthlyTaskEntryController.shared.delete(monthlyTaskEntry: monthlyTaskEntry)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
        
    //MARK: - Alert Controller
    func setUpAlertController(){
        
        var monthlyTaskTextField: UITextField?
        
        let alertController = UIAlertController(title: "Add a Monthly Task", message: "What do you need to get done this month?", preferredStyle: .alert)
        
        alertController.addTextField { (textField) in
            textField.keyboardType = .default
            monthlyTaskTextField = textField
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .default) {
            (_) in
        }
        
        let addMonthlyTaskEntryAction = UIAlertAction(title: "Add", style: .default) {
            (_) in
            guard let monthlyTaskEntryName = monthlyTaskTextField?.text else { return }
            MonthlyTaskEntryController.shared.createMonthlyTaskEntryWith(name: monthlyTaskEntryName, bulletType: "-")
            let monthlyTaskEntries = MonthlyTaskEntryController.shared.monthlyTaskEntries.count
            self.tableView.beginUpdates()
            self.tableView.insertRows(at: [IndexPath.init(row: monthlyTaskEntries - 1, section: 0)], with: .automatic)
            self.tableView.endUpdates()
        }
        
        alertController.addAction(cancelAction)
        alertController.addAction(addMonthlyTaskEntryAction)
        
        present(alertController, animated: true, completion: nil)
        
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
