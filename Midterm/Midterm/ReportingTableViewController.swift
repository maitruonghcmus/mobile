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
    func calcTodayRevenue() -> Double {
        //let orders = DataContext.Instance.Orders.all()
        let orders = AppContext.Instance.Orders
        let count = orders.count
        var sum = 0.0
        
        if count > 0{
            for i in 0..<count {
                if orders[i].OrderDate == Date() {
                    sum += orders[i].Total
                }
            }
        }
        return sum
    }
    
    func calcThisMonthRevenue() -> Double {
        //let orders = DataContext.Instance.Orders.all()
        let orders = AppContext.Instance.Orders
        let count = orders.count
        var sum = 0.0
        if count > 0{
            for i in 0..<count {
                let orderMonth = AppUtils.GetMonthOfDate(date: orders[i].OrderDate)
                let currentMonth = AppUtils.GetMonthOfDate(date: Date())
                let orderYear = AppUtils.GetYearOfDate(date: orders[i].OrderDate)
                let currentYear = AppUtils.GetYearOfDate(date: Date())
                
                if orderMonth == currentMonth && orderYear == currentYear {
                    sum += orders[i].Total
                }
            }
        }
        return sum
    }
    
    func calcThisYearRevenue() -> Double {
        //let orders = DataContext.Instance.Orders.all()
        let orders = AppContext.Instance.Orders
        let count = orders.count
        var sum = 0.0
        if count > 0{
            for i in 0..<count {
                
                let orderYear = AppUtils.GetYearOfDate(date: orders[i].OrderDate)
                let currentYear = AppUtils.GetYearOfDate(date: Date())
                
                if orderYear == currentYear {
                    sum += orders[i].Total
                }
            }
        }
        return sum
    }
    
    //MARK: - UI EVENT
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let today = Date()
        let month = AppUtils.GetMonthOfDate(date: today)
        let year = AppUtils.GetYearOfDate(date: today)
        
        lblToday.text = "Today: " + AppUtils.FormatCurrency(money: AppContext.Instance.calcRevenueByDate(date: today))
        
        lblThisMonth.text = "This month: " + AppUtils.FormatCurrency(money: AppContext.Instance.calcRevenueByMonth(month: month, year: year))
        
        lblThisYear.text = "This year: " + AppUtils.FormatCurrency(money: AppContext.Instance.calcRevenueByYear(year: year))
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
