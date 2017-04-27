//
//  TestTableViewController.swift
//  Midterm
//
//  Created by Truong Mai on 4/27/17.
//  Copyright © 2017 IMIT. All rights reserved.
//

import UIKit

class MainTableViewController: UITableViewController {
    
    //MARK: - VARIABLE
    var tables = [Table]()
    var orders = [Order]()
    var selectedTable = Table()
    var selectedOrder = Order()
    
    //MARK: - UI ELEMENT
    
    //MARK: - CUSTOM FUNCTION
    
    //MARK: - UI EVENT
    override func viewWillAppear(_ animated: Bool) {
        tables = DataContext.Instance.Tables.all()
        for table in tables {
            orders.append(DataContext.Instance.Orders.getByTableFree(id: table.Id))
        }
        tableView.reloadData()
        self.navigationController?.setToolbarHidden(true, animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: - TABLE VIEW
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tables.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MainTableViewCell", for: indexPath) as! MainTableViewCell
        
        let table = tables[indexPath.row]
        let order = orders[indexPath.row]
        
        cell.lblTest.text = table.Name
        cell.lblFoodItems.text = AppUtils.formatDate(date: order.OrderDate)
        cell.lblQuantity.text = String(format: "%f", order.Total)
        
        if table.TableStatus == 1 {
            cell.backgroundColor = UIColor.yellow
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedTable = tables[indexPath.row]
        selectedOrder = orders[indexPath.row]
        performSegue(withIdentifier: "SegueShowOrderDetailID", sender: nil)
    }
    
     //MARK: - NAVIGATION
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SegueShowOrderDetailID" {
            let destination = segue.destination as! MainTableDetailTableViewController
            destination.isTableAvailable = true
            destination.currentTable = selectedTable
            destination.currentOrder = selectedOrder
        }
     }
}
