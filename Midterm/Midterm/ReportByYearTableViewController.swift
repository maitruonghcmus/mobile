//
//  ReportByYearTableViewController.swift
//  Midterm
//
//  Created by Truong Mai on 4/27/17.
//  Copyright © 2017 IMIT. All rights reserved.
//

import UIKit

class ReportByYearTableViewController: UITableViewController {

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
        return 5
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReportByYearTableViewCell", for: indexPath) as! ReportByYearTableViewCell
        
        let year = AppUtils.GetYearOfDate(date: Date()) - indexPath.row
        cell.lblYear.text = String(year)
        cell.lblTotal.text = AppUtils.FormatCurrency(money: AppContext.Instance.calcRevenueByYear(year: year))
        
        return cell
    }
}
