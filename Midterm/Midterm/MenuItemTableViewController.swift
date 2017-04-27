//
//  MenuItemTableViewController.swift
//  Midterm
//
//  Created by An Le on 4/27/17.
//  Copyright © 2017 IMIT. All rights reserved.
//

import UIKit

class MenuItemTableViewController: UITableViewController {
    // MARK: - local variant
    var menuitems = [MenuItem]()
    // MARK: - Delegate areaview
    func reload() {
        menuitems = DataContext.Instance.MenuItems.all()
        tableView.reloadData()
    }
    override func viewWillAppear(_ animated: Bool) {
        reload()
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 300
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return menuitems.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "menuitemviewcell", for: indexPath) as! MenuItemTableViewCell
        let menuitem = self.menuitems[indexPath.row]
        cell.nameText.text  = "\(menuitem.Name)"
        cell.priceText.text  = "\(menuitem.Price)"
        cell.descriptionText.text  = "\(menuitem.Description)"

        return cell
    }
 

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    @IBAction func clickAddButton(_ sender: Any) {
        performSegue(withIdentifier: "SegueShowMenuItemID", sender: nil)
    }

    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let edit = UITableViewRowAction(style: .normal, title: "Edit") { action, index in
            self.performSegue(withIdentifier: "SegueShowMenuItemID", sender: index.row)
        }
        
        let delete = UITableViewRowAction(style: .destructive, title: "Delete") { action, index in
            if DataContext.Instance.MenuItems.delete(id: self.menuitems[index.row].Id) == true {
                self.reload()
            }
            else {
                AppUtils.DisplayAlertMessage(title: "Error", message: "Area delete fail", controller: self)
            }
        }
        
        return [delete, edit]
    }
    
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
        if segue.identifier == "SegueShowMenuItemID" {
            let destination = segue.destination as! MenuItemViewController
            if sender != nil {
                let row = sender as! Int
                destination.menuitem = self.menuitems[row]
                destination.title = "Edit menuitem"
            }
            else {
                destination.title = "Add menuitem"
            }
        }
    }
    

}
