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
    var selectedTable = Table()
    
    //MARK: - UI ELEMENT
    
    //MARK: - CUSTOM FUNCTION
    
    //MARK: - UI EVENT
    override func viewWillAppear(_ animated: Bool) {
        tables = AppContext.Instance.Tables
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
        
        cell.lblTest.text = String(table.Id)
        cell.lblFoodItems.text = "10-10-2017, 11:11"
        cell.lblQuantity.text = "300.000"
        
        if table.TableStatus == 1 {
            cell.backgroundColor = UIColor.yellow
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedTable = tables[indexPath.row]
    }
    
     //MARK: - NAVIGATION
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SegueShowTableDetailID" {
            let destination = segue.destination as! MainTableDetailTableViewController
            if sender != nil {
                if selectedTable.Id > 0 && selectedTable.TableStatus == 0 {
                    destination.isTableAvailable = true
                    destination.currentTable = selectedTable
                }
            }
        }
     }
}
