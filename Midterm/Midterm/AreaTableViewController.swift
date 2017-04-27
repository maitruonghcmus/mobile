//
//  AreaController.swift
//  Midterm
//
//  Created by An Le on 4/23/17.
//  Copyright © 2017 IMIT. All rights reserved.
//

import UIKit

class AreaTableViewController: UITableViewController {

    var areas = [Area]()
    
    func loadData() {
        //areas = DataContext.Instance.Areas.all()
        areas = AppContext.Instance.Areas
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 300
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
        return self.areas.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AreaTableViewCell", for: indexPath) as! AreaTableViewCell
        let area = self.areas[indexPath.row]
        cell.descriptionLabel.text  = "\(area.Name) \n\(area.Description)"
        return cell
    }
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
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
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let edit = UITableViewRowAction(style: .normal, title: "Edit") { action, index in
            self.performSegue(withIdentifier: "SegueShowAreaViewID", sender: index.row)
        }
        
        let delete = UITableViewRowAction(style: .destructive, title: "Delete") { action, index in
            
            //alert
            let alert = UIAlertController(title: "Delete Area " + "\(self.areas[index.row].Name)", message: "Are you sure to do this action?", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
                
                //DataContext.Instance.Areas.delete(id: self.areas[index.row].Id)
                _ = AppContext.Instance.RemoveArea(area: self.areas[index.row])
                
                self.loadData()
                tableView.reloadData()
            }))
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
           
            self.loadData()
            tableView.reloadData()
        }
        
        return [delete, edit]
    }
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

    @IBAction func clickAddButton(_ sender: Any) {
        performSegue(withIdentifier: "SegueShowAreaViewID", sender: nil)
    }
    
    @IBAction func unwindToAreaTableView(unwindSegue: UIStoryboardSegue) {
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "SegueShowAreaViewID" {
            let destination = segue.destination as! AreaViewController
            if sender != nil {
                let row = sender as! Int
                destination.area = self.areas[row]
                destination.title = "Edit area"
            }
            else {
                destination.title = "Add area"
            }
        }
    }
    

}
