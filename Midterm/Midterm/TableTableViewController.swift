//
//  TableTableViewController.swift
//  Midterm
//
//  Created by Truong Mai on 4/26/17.
//  Copyright © 2017 IMIT. All rights reserved.
//

import UIKit


class TableTableViewController: UITableViewController {

    //MARK: - VARIABLE
        var tables = [Table]()
    
    //MARK: - UI ELEMENT
    
    
    //MARK: - CUSTOM FUNCTION
    func loadData() {
        tables = DataContext.Instance.Tables.all()
        tableView.reloadData()
    }
    
    //MARK: - UI EVENT
    override func viewWillAppear(_ animated: Bool) {
        loadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func clickAddButton(_ sender: Any) {
        performSegue(withIdentifier: "SegueShowTableViewID", sender: nil)
    }
    
    //MARK: - TABLE VIEW
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tables.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableTableViewCell", for: indexPath) as! TableTableViewCell
        let table = self.tables[indexPath.row]
        
        cell.lblTableName.text  = "\(table.Name)"
        cell.lblAreaName.text = "\((table.Area?.Name)!)"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let edit = UITableViewRowAction(style: .normal, title: "Edit") { action, index in
            self.performSegue(withIdentifier: "SegueShowTableViewID", sender: index.row)
        }
        
        let delete = UITableViewRowAction(style: .destructive, title: "Delete") { action, index in
            
            
            //alert
            let alert = UIAlertController(title: "Delete table " + "\(self.tables[index.row].Id)", message: "Are you sure to do this action?", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
                if DataContext.Instance.Tables.delete(id: self.tables[index.row].Id) == true {
                    self.loadData()
                }
                else {
                    AppUtils.DisplayAlertMessage(title: "Error", message: "Table delete fail", controller: self)
                }
            }))
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
            //DataContext.Instance.Tables.delete(id: self.tables[index.row].Id)
            self.loadData()
            tableView.reloadData()
        }
        
        return [delete, edit]
    }

    //MARK: - NAVIGATION
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SegueShowTableViewID" {
            let destination = segue.destination as! TableViewController
            if sender != nil {
                let row = sender as! Int
                destination.table = self.tables[row]
                destination.title = "Edit table"
            }
            else {
                destination.title = "Add table"
            }
        }
    }
}
