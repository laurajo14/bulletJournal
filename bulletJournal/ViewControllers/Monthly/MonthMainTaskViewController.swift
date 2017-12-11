//
//  MonthMainTaskViewController.swift
//  bulletJournal
//
//  Created by Laura O'Brien on 12/8/17.
//  Copyright © 2017 Laura O'Brien. All rights reserved.
//

import UIKit
import CoreData

class MonthMainTaskViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, NSFetchedResultsControllerDelegate {

    //MARK: - Properties
    var isSlideMenuHidden = true
    var monthlyTaskEntry: MonthlyTaskEntry?
    
    //FetchedResultsController
    var fetchedResultsController: NSFetchedResultsController<MonthlyTaskEntry>!
    
    func configureFetchedResultsController() {
        if fetchedResultsController == nil {
            let fetchRequest: NSFetchRequest<MonthlyTaskEntry> =
                MonthlyTaskEntry.fetchRequest()
            fetchRequest.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
//>>
            let frc = NSFetchedResultsController<MonthlyTaskEntry>(fetchRequest: fetchRequest, managedObjectContext: CoreDataStack.context, sectionNameKeyPath: "bulletType", cacheName: nil)
            
            fetchedResultsController = frc
            frc.delegate = self
        }
        do {
            try fetchedResultsController.performFetch()
        } catch {
            NSLog("Error starting fetched results controller: error \(error)")
        }
    }
    
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
    func setUpDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    
    //MARK: - View Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        configureFetchedResultsController()
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
        return fetchedResultsController.fetchedObjects?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "monthlyTaskCell", for: indexPath) as? MonthlyTaskTableViewCell else { return MonthlyTaskTableViewCell() }
        
        guard let monthlyTaskEntries = fetchedResultsController.fetchedObjects else { return cell }
        
        let monthlyTaskEntry = monthlyTaskEntries[indexPath.row]
        cell.monthlyTaskEntry = monthlyTaskEntry
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            guard let monthlyTaskEntries = fetchedResultsController.fetchedObjects else { return }
            
            let monthlyTaskEntry = monthlyTaskEntries[indexPath.row]
            MonthlyTaskEntryController.shared.delete(monthlyTaskEntry: monthlyTaskEntry)
        }
    }
    
    //MARK: - NSFetchedResultsControllerDelegate
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>,
                    didChange anObject: Any,
                    at indexPath: IndexPath?,
                    for type: NSFetchedResultsChangeType,
                    newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            guard let newIndexPath = newIndexPath else { return }
            tableView.insertRows(at: [newIndexPath], with: .automatic)
        case .delete:
            guard let indexPath = indexPath else { return }
            tableView.deleteRows(at: [indexPath], with: .fade)
        case .move:
            tableView.reloadData()
        case .update:
            guard let indexPath = indexPath else { return }
            tableView.reloadRows(at: [indexPath], with: .automatic)
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
            guard let monthlyTaskEntry = monthlyTaskTextField?.text else { return }
            MonthlyTaskEntryController.shared.createMonthlyTaskEntryWith(name: (monthlyTaskTextField?.text)!, bulletType: "●")
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
