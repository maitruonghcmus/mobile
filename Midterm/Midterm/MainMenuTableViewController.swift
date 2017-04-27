//
//  MainMenuTableViewController.swift
//  Midterm
//
//  Created by Truong Mai on 4/27/17.
//  Copyright © 2017 IMIT. All rights reserved.
//

import UIKit

class MainMenuTableViewController: UITableViewController {

    var menuitems = [MenuItem]()
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        menuitems = DataContext.Instance.MenuItems.all()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuitems.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MainMenuTableViewCell", for: indexPath) as! MainMenuTableViewCell
        
        cell.lblName.text = menuitems[indexPath.row].Name
        cell.lblPrice.text = AppUtils.FormatCurrency(money: menuitems[indexPath.row].Price)
        cell.lblDescription.text = menuitems[indexPath.row].Description
        
        return cell
    }
}
