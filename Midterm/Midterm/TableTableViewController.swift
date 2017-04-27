//
//  TableTableViewController.swift
//  Midterm
//
//  Created by Truong Mai on 4/26/17.
//  Copyright © 2017 IMIT. All rights reserved.
//

import UIKit


class TableTableViewController: UITableViewController, ReloadTableTableDelegate {

    //MARK: *** DATA MODELS
    var tables = [Table]()
    
    
    //MARK: *** UI ELEMENTS
    func reload() {
        tables = DataContext.Instance.Tables.all()
        tableView.reloadData()
    }
    
    
    //MARK: *** UI EVENT
    
    
    
    //MARK: *** CUSTOM FUNCTION
    func loadData() {
        //tables = DataContext.Instance.Tables.all()
        tables = AppContext.Instance.Tables
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadData()
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData();
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.tables.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        let cell = tableView.dequeueReusableCell(withIdentifier: "TableTableViewCell", for: indexPath) as! TableTableViewCell
        let table = self.tables[indexPath.row]
        
        cell.lblTableName.text  = "\(table.Name)"
        cell.lblAreaName.text = "\((table.Area?.Name)!)"
        return cell
    }
    
    
    //Override for gesture
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let edit = UITableViewRowAction(style: .normal, title: "Edit") { action, index in
            self.performSegue(withIdentifier: "SegueShowTableViewID", sender: index.row)
        }
        
        let delete = UITableViewRowAction(style: .destructive, title: "Delete") { action, index in
            
            
            //alert
            let alert = UIAlertController(title: "Delete table " + "\(self.tables[index.row].Id)", message: "Are you sure to do this action?", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
                if DataContext.Instance.Tables.delete(id: self.tables[index.row].Id) == true {
                    self.reload()
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
    
    @IBAction func clickAddButton(_ sender: Any) {
        performSegue(withIdentifier: "SegueShowTableViewID", sender: nil)
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
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
            destination.delegate = self
        }
    }
 

}
