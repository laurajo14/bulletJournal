//
//  DailyViewController.swift
//  bulletJournal
//
//  Created by Laura O'Brien on 12/4/17.
//  Copyright © 2017 Laura O'Brien. All rights reserved.
//

import UIKit
import CoreData

class DailyViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, bulletTableViewCellDelegate {
    
    //MARK: - Properties
    var thoughtEntry: ThoughtEntry?
    
    var hours: [String] = ["6:00", "7:00", "8:00", "9:00", "10:00", "11:00", "12:00PM", "1:00", "2:00", "3:00", "4:00", "5:00", "6:00", "7:00", "8:00", "9:00", "10:00", "11:00", "12:00AM", "1:00", "2:00", "3:00", "4:00", "5:00"]
    
    //MARK: - Outlets
    @IBOutlet weak var bulletTableView: UITableView!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var addEntryButton: UIButton!
    
    //MARK: - Actions
    @IBAction func addEntryButtonTapped(_ sender: Any) {
        setUpAlertController()
    }
    
    //MARK: - TableView Functions
    func setDelegates() {
        bulletTableView.delegate = self
        bulletTableView.dataSource = self
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    //MARK: - View Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegates()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.bulletTableView.reloadData()
        
    }
    
    // MARK: - TableView Data Sources
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if tableView == bulletTableView {
            return 1
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == bulletTableView {
            return ThoughtEntryController.shared.thoughtEntries.count
        } else {
            return 24
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == bulletTableView {
            guard let cell = bulletTableView.dequeueReusableCell(withIdentifier: "bulletCell", for: indexPath) as? bulletTableViewCell else { return UITableViewCell() }
            
            let thoughtEntry = ThoughtEntryController.shared.thoughtEntries[indexPath.row]
            cell.thoughtEntry = thoughtEntry
            cell.delegate = self
            
            return cell
            
        } else {
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "eventCell", for: indexPath) as? eventTableViewCell else { return UITableViewCell() }
            
            cell.timeLabel.text = self.hours[indexPath.row]
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if tableView == bulletTableView {
            if editingStyle == .delete {
                let thoughtEntry = ThoughtEntryController.shared.thoughtEntries[indexPath.row]
                ThoughtEntryController.shared.delete(thoughtEntry: thoughtEntry)
               
                self.bulletTableView.deleteRows(at: [indexPath], with: .fade)
            }
        } else { return }
    }
    
    
    //MARK: - AlertController
    func setUpAlertController(){
        
        let alertController = UIAlertController(title: "Add a Bullet Entry", message: "What kind of bullet entry would you like to create?", preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .default) {
            (_) in
        }
        
        let addThoughtEntryAction = UIAlertAction(title: "Thought", style: .default) {
            (_) in
            ThoughtEntryController.shared.createThoughtEntryWith(name: "")
            self.bulletTableView.reloadData()
     
        }
        
        let addTaskEntryAction = UIAlertAction(title: "Task", style: .default) {
            (_) in
            
        }
        
        let addEventEntryAction = UIAlertAction(title: "Event", style: .default) {
            (_) in
        }
        
        alertController.addAction(addEventEntryAction)
        alertController.addAction(addTaskEntryAction)
        alertController.addAction(addThoughtEntryAction)
        alertController.addAction(cancelAction)
        
        
        present(alertController, animated: true, completion: nil)
        
    }
    
    //MARK: - bulletTableViewCell Delegate
    //    func bulletTableViewCellCompleteButtonTapped(_ cell: bulletTableViewCell) {
    //
    //        guard let indexPath = tableView.indexPath(for: cell),
    //            let item = fetchedResultsController.fetchedObjects?[indexPath.row] else { return }
    //
    //        item.isComplete = !item.isComplete
    //        ThoughtEntryController.shared.saveToPersistentStore()
    //
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
