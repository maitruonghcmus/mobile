//
//  ReportingTableViewController.swift
//  Midterm
//
//  Created by Truong Mai on 4/27/17.
//  Copyright © 2017 IMIT. All rights reserved.
//

import UIKit

class ReportingTableViewController: UITableViewController {

    //MARK: - VARIABLE
    
    //MARK: - UI ELEMENT
    
    @IBOutlet weak var lblToday: UILabel!
    @IBOutlet weak var lblThisMonth: UILabel!
    @IBOutlet weak var lblThisYear: UILabel!
    
    
    //MARK: - CUSTOM FUNCTION
    func calcTodayRevenue() -> Float {
        return 0.0
    }
    
    func calcThisMonthRevenue() -> Float {
        return 0.0
    }
    
    func calcThisYearRevenue() -> Float {
        return 0.0
    }
    
    //MARK: - UI EVENT
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lblToday.text = "Today: " + String(self.calcTodayRevenue())
        lblThisMonth.text = "This month: " + String(self.calcThisMonthRevenue())
        lblThisYear.text = "This year: " + String(self.calcThisYearRevenue())
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    //MARK: - TABLE VIEW

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
}
