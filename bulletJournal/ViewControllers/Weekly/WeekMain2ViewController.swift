//
//  WeekMain2ViewController.swift
//  bulletJournal
//
//  Created by Laura O'Brien on 12/4/17.
//  Copyright © 2017 Laura O'Brien. All rights reserved.
//

import UIKit

class WeekMain2ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

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
    
    //MARK: - TableViewFunctions
    func setUpTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    //MARK: - View LifeCycles
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
    
    //MARK: - TableView Data Source
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let weeklyTaskEntries = WeeklyTaskEntryController.shared.weeklyTaskEntries.count
        return (weeklyTaskEntries > 0) ? weeklyTaskEntries : 0
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "weeklyTaskCell", for: indexPath) as? WeeklyTaskTableViewCell else {
            return UITableViewCell ()
        }
        
        let weeklyTaskEntry = WeeklyTaskEntryController.shared.weeklyTaskEntries[indexPath.row]
        cell.weeklyTaskEntries = weeklyTaskEntry
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            let weeklyTaskEntry = WeeklyTaskEntryController.shared.weeklyTaskEntries[indexPath.row]
            WeeklyTaskEntryController.shared.delete(weeklyTaskEntry: weeklyTaskEntry)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    //MARK: - Alert Controller
    func setUpAlertController(){
        
        var weeklyTaskTextField: UITextField?
        
        let alertController = UIAlertController(title: "Add a Weekly Task", message: "What do you need to get done this week?", preferredStyle: .alert)
        
        alertController.addTextField { (textField) in
            textField.keyboardType = .default
            weeklyTaskTextField = textField
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .default) {
            (_) in
        }
        
        let addWeeklyTaskEntryAction = UIAlertAction(title: "Add", style: .default) {
            (_) in
            guard let weeklyTaskEntryName = weeklyTaskTextField?.text else { return }
            WeeklyTaskEntryController.shared.createWeeklyTaskEntryWith(name: weeklyTaskEntryName, bulletType: "-")
            let weeklyTaskEntries = WeeklyTaskEntryController.shared.weeklyTaskEntries.count
            self.tableView.beginUpdates()
            self.tableView.insertRows(at: [IndexPath.init(row: weeklyTaskEntries - 1, section: 0)], with: .automatic)
            self.tableView.endUpdates()
        }
        
        alertController.addAction(cancelAction)
        alertController.addAction(addWeeklyTaskEntryAction)
        
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
