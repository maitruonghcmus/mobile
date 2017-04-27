//
//  ReportByMonthTableViewController.swift
//  Midterm
//
//  Created by Truong Mai on 4/27/17.
//  Copyright © 2017 IMIT. All rights reserved.
//

import UIKit

class ReportByMonthTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 12
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReportByMonthTableViewCell", for: indexPath) as! ReportByMonthTableViewCell
        
        cell.lblMonth.text = "\(indexPath.row + 1)/" + String(AppUtils.GetYearOfDate(date: Date()))
        cell.lblTotal.text = AppUtils.FormatCurrency(money: AppContext.Instance.calcRevenueByMonth(month: indexPath.row + 1, year: AppUtils.GetYearOfDate(date: Date())))
        
        return cell
    }
}
