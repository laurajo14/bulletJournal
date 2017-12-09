//
//  MonthMainViewController.swift
//  bulletJournal
//
//  Created by Laura O'Brien on 12/4/17.
//  Copyright © 2017 Laura O'Brien. All rights reserved.
//

import UIKit
import CoreData

class MonthMainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    //MARK: - Properties
    var isSlideMenuHidden = true
    
    ///Creating array of monthly days
    var daysOfTheMonthArray = Date().generateDatesArrayBetweenTwoDates(startDate: Date().startOfMonth(), endDate: Date().endOfMonth())

    //MARK: - Outlets
    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var sideMenuWidthConstraint: NSLayoutConstraint!

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
    
    //MARK: - TableView Functions
    func setDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    
    //MARK: - View Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegates()
        setUpMonthLabel()
        sideMenuWidthConstraint.constant = 0
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(false)
        sideMenuWidthConstraint.constant = 0
    }

    //MARK: - Date Formatting
    func setUpMonthLabel() {
        let currentDate = Date(timeInterval: 0, since: Date())
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM"
        let thisMonth = formatter.string(from: currentDate).uppercased()
        monthLabel.text = "\(thisMonth)"
    }
    
    //MARK: - TableView Data Source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 31
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "monthlyEventCell", for: indexPath) as? MonthlyEventTableViewCell else { return UITableViewCell() }
        
        //Want array of monthly days
        let formatter = DateFormatter()
        formatter.dateFormat = "dd E"
        
        cell.dateLabel.text = formatter.string(from: daysOfTheMonthArray[indexPath.row])
        
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

extension Date {
    func startOfMonth() -> Date {
        return Calendar.current.date(from: Calendar.current.dateComponents([.year, .month, .day], from: Calendar.current.startOfDay(for: self)))!
    }
    
    func endOfMonth() -> Date {
        return Calendar.current.date(byAdding: DateComponents(month: 1, day: -1), to: self.startOfMonth())!
    }
    
    func generateDatesArrayBetweenTwoDates(startDate: Date , endDate:Date) ->[Date]
    {
        var datesArray: [Date] =  [Date]()
        var startDate = startDate
        let calendar = Calendar.current
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        while startDate <= endDate {
            datesArray.append(startDate)
            startDate = calendar.date(byAdding: .day, value: 1, to: startDate)!
            
        }
        return datesArray
    }
}
