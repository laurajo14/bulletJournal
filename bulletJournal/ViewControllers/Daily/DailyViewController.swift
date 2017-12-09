//
//  DailyViewController.swift
//  bulletJournal
//
//  Created by Laura O'Brien on 12/4/17.
//  Copyright © 2017 Laura O'Brien. All rights reserved.
//

import UIKit
import CoreData

class DailyViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, DailyScheduleTableViewCellDelegate, BulletTableViewCellDelegate, UITextFieldDelegate {
    
    //MARK: - Properties
    var isSlideMenuHidden = true
    
    var thoughtEntry: ThoughtEntry?
    var taskEntry: TaskEntry?
    var eventEntry: EventEntry?
    var dailyScheduleEntry: DailyScheduleEntry?
    
    var thoughtEntries = ThoughtEntryController.shared.thoughtEntries.count
    var taskEntries = TaskEntryController.shared.taskEntries.count
    var eventEntries = EventEntryController.shared.eventEntries.count
    
    let hours: [String] = ["6:00", "7:00", "8:00", "9:00", "10:00", "11:00", "12:00 PM", "1:00", "2:00", "3:00", "4:00", "5:00", "6:00", "7:00", "8:00", "9:00", "10:00", "11:00", "12:00 AM", "1:00", "2:00", "3:00", "4:00", "5:00"]
    
    //MARK: - FetchedResultsController
    var fetchedResultsController: NSFetchedResultsController<DailyScheduleEntry>?

    func configureFetchedResultsController() {
        if fetchedResultsController == nil {
            let fetchRequest: NSFetchRequest<DailyScheduleEntry> =
                DailyScheduleEntry.fetchRequest()
            let frc = NSFetchedResultsController<DailyScheduleEntry>(fetchRequest: fetchRequest, managedObjectContext: CoreDataStack.context, sectionNameKeyPath: nil, cacheName: nil)
            /*(fetchRequest: fetchRequest, managedObjectContext: CoreDataStack.context, sectionNameKeyPath: "name", cacheName: nil)*/
            frc.delegate = self as? NSFetchedResultsControllerDelegate
            fetchedResultsController = frc
        }
        do {
            try fetchedResultsController?.performFetch()
        } catch {
            NSLog("Error starting fetched results controller: error \(error)")
        }
    }
    
    //MARK: - Outlets
    @IBOutlet weak var sideMenuConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var bulletTableView: UITableView!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var addEntryButton: UIButton!
    
    //MARK: - Actions
    @IBAction func addEntryButtonTapped(_ sender: Any) {
        setUpAlertController()
    }
    
    @IBAction func menuButtonTapped(_ sender: UIBarButtonItem) {
        if isSlideMenuHidden {
            sideMenuConstraint.constant = 0
            UIView.animate(withDuration: 0.3, animations: {
                self.view.layoutIfNeeded()
            })
        } else {
            sideMenuConstraint.constant = -180
            
            UIView.animate(withDuration: 0.3, animations: {
                self.view.layoutIfNeeded()
            })
        }
        isSlideMenuHidden = !isSlideMenuHidden
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
        setUpDateLabels()
        sideMenuConstraint.constant = -180
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.bulletTableView.reloadData()
        self.tableView.reloadData()
    }
    
    //MARK: - Date Label
    func setUpDateLabels() {
        let currentDate = Date(timeInterval: 0, since: Date())
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM dd"
        let today = formatter.string(from: currentDate).uppercased()
        dateLabel.text = "\(today)"
    }
    
    // MARK: - TableView Data Sources
    func numberOfSections(in tableView: UITableView) -> Int {
        if tableView == bulletTableView {
            return 3
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if tableView == bulletTableView {
            switch section {
            case 0:
                return "Thoughts"
            case 1:
                return "Tasks"
            case 2:
                return "Events"
            default:
                return "default"
            }
        } else {
            return ""
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == bulletTableView {
            
            if section == 0 {
                let thoughtEntries = ThoughtEntryController.shared.thoughtEntries.count
                return (thoughtEntries > 0) ? thoughtEntries : 0
            }
            else if section == 1 {
                let taskEntries = TaskEntryController.shared.taskEntries.count
                return (taskEntries > 0) ? taskEntries : 0
            }
            else if  section == 2  {
                let eventEntries = EventEntryController.shared.eventEntries.count
                return (eventEntries > 0) ? eventEntries : 0
            }
            else {
                return 0
            }
        }
        else {
            return 24
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == bulletTableView {
            guard let cell = bulletTableView.dequeueReusableCell(withIdentifier: "bulletCell", for: indexPath) as? BulletTableViewCell else { return UITableViewCell() }
            
            cell.delegate = self
            
            return cell
            
        } else {
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "dailyScheduleCell", for: indexPath) as? DailyScheduleTableViewCell else { return UITableViewCell() }
            
            cell.timeLabel.text = self.hours[indexPath.row]
            ///how does it know to save to that specific row?
            cell.dailyScheduleEntryTF.text = dailyScheduleEntry?.name
            
            cell.delegate = self
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if tableView == bulletTableView {
            if editingStyle == .delete {
                
                switch indexPath.section {
                case 0:
                    let thoughtEntry = ThoughtEntryController.shared.thoughtEntries[indexPath.row]
                    ThoughtEntryController.shared.delete(thoughtEntry: thoughtEntry)
                case 1:
                    let taskEntry = TaskEntryController.shared.taskEntries[indexPath.row]
                    TaskEntryController.shared.delete(taskEntry: taskEntry)
                case 2:
                    let eventEntry = EventEntryController.shared.eventEntries[indexPath.row]
                    EventEntryController.shared.delete(eventEntry: eventEntry)
                default:
                    break
                }
                
                self.bulletTableView.deleteRows(at: [indexPath], with: .fade)
            }
            
        } else {
            return
        }
    }
    
    
    //MARK: - AlertController
    func setUpAlertController(){
        
        let alertController = UIAlertController(title: "Add a Bullet Entry", message: "What kind of bullet entry would you like to create?", preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .default) {
            (_) in
        }
        
        let addThoughtEntryAction = UIAlertAction(title: "Thought", style: .default) {
            (_) in
            ThoughtEntryController.shared.createThoughtEntryWith(name: "thought entry")
            let thoughtEntries = ThoughtEntryController.shared.thoughtEntries.count
            self.bulletTableView.beginUpdates()
            self.bulletTableView.insertRows(at: [IndexPath.init(row: thoughtEntries - 1, section: 0)], with: .automatic)
            self.bulletTableView.endUpdates()
            
        }
        
        let addTaskEntryAction = UIAlertAction(title: "Task", style: .default) {
            (_) in
            TaskEntryController.shared.createTaskEntryWith(name: "task entry")
            let taskEntries = TaskEntryController.shared.taskEntries.count
            self.bulletTableView.beginUpdates()
            self.bulletTableView.insertRows(at: [IndexPath.init(row: taskEntries - 1, section: 1)], with: .automatic)
            self.bulletTableView.endUpdates()
        }
        
        let addEventEntryAction = UIAlertAction(title: "Event", style: .default) {
            (_) in
            EventEntryController.shared.createEventEntryWith(name: "event entry")
            let eventEntries = EventEntryController.shared.eventEntries.count
            self.bulletTableView.beginUpdates()
            self.bulletTableView.insertRows(at: [IndexPath.init(row: eventEntries - 1, section: 2)], with: .automatic)
            self.bulletTableView.endUpdates()
        }
        
        alertController.addAction(addEventEntryAction)
        alertController.addAction(addTaskEntryAction)
        alertController.addAction(addThoughtEntryAction)
        alertController.addAction(cancelAction)
        
        
        present(alertController, animated: true, completion: nil)
        
    }
    
    //MARK: - DailyScheduleTableViewCell Delegate
    func DailyScheduleTableViewCellTextFieldDidEndEditing(_ cell: DailyScheduleTableViewCell) {
        
//        guard let indexPath = tableView.indexPath(for: cell),
//            let dailyScheduleEntry = fetchedResultsController?.fetchedObjects?[indexPath.row]
//            else { return }

//        var dailyScheduleEntryTF: UITextField?
//        guard let dailyScheduleEntry.name = dailyScheduleEntryTF?.text else { return }
//        DailyScheduleEntryController.shared.createDailyScheduleEntryWith(name: dailyScheduleEntryTF.text))
//        }
        DailyScheduleEntryController.shared.saveToPersistentStore()
    }
}

/*
 // MARK: - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
 // Get the new view controller using segue.destinationViewController.
 // Pass the selected object to the new view controller.
 }
 */


