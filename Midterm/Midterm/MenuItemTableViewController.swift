//
//  MenuItemTableViewController.swift
//  Midterm
//
//  Created by An Le on 4/27/17.
//  Copyright © 2017 IMIT. All rights reserved.
//

import UIKit

class MenuItemTableViewController: UITableViewController {
    
    //MARK: - VARIABLE
        var menuitems = [MenuItem]()
    
    //MARK: - UI ELEMENT
    
    //MARK: - CUSTOM FUNCTION
    func reload() {
        menuitems = DataContext.Instance.MenuItems.all()
        tableView.reloadData()
    }
    
    //MARK: - UI EVENT
    override func viewWillAppear(_ animated: Bool) {
        reload()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 300
        tableView.rowHeight = 115
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func clickAddButton(_ sender: Any) {
        performSegue(withIdentifier: "SegueShowMenuItemID", sender: nil)
    }
    
    //MARK: - TABLE VIEW
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
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
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    
    //MARK: - NAVIGATION
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
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
