//
//  AreaController.swift
//  Midterm
//
//  Created by An Le on 4/23/17.
//  Copyright © 2017 IMIT. All rights reserved.
//

import UIKit

class AreaTableViewController: UITableViewController {
    
    //MARK: - VARIABLE
    var areas = [Area]()
    // MARK: - Delegate areaview
    func reload() {
        areas = DataContext.Instance.Areas.all()
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
    }
    
    //MARK: - UI EVENT
    
    
    // MARK: - TABLE VIEW
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.areas.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AreaTableViewCell", for: indexPath) as! AreaTableViewCell
        let area = self.areas[indexPath.row]
        cell.descriptionLabel.text  = "\(area.Name) \n\(area.Description)"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let edit = UITableViewRowAction(style: .normal, title: "Edit") { action, index in
            self.performSegue(withIdentifier: "SegueShowAreaViewID", sender: index.row)
        }
        
        let delete = UITableViewRowAction(style: .destructive, title: "Delete") { action, index in
            
            //alert
            let alert = UIAlertController(title: "Delete Area " + "\(self.areas[index.row].Name)", message: "Are you sure to do this action?", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
                if DataContext.Instance.Areas.delete(id: self.areas[index.row].Id) == true {
                    self.reload()
                }
                else {
                    AppUtils.DisplayAlertMessage(title: "Error", message: "Area delete fail", controller: self)
                }
            }))
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
        return [delete, edit]
    }
    
    @IBAction func clickAddButton(_ sender: Any) {
        performSegue(withIdentifier: "SegueShowAreaViewID", sender: nil)
    }
    
    
    // MARK: - NAVIGATION
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
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
