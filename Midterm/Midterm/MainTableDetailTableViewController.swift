//
//  MainTableTableViewController.swift
//  Midterm
//
//  Created by Truong Mai on 4/27/17.
//  Copyright © 2017 IMIT. All rights reserved.
//

import UIKit

class MainTableDetailTableViewController: UITableViewController {

    //MARK: - VARIABLE
    var isTableAvailable = false
    var currentTable = Table()
    var currentOrder = Order()
    
    //MARK: - UI ELEMENT
    
    //MARK: - CUSTOM FUNCTION
    
    //MARK: - UI EVENT
    override func viewWillAppear(_ animated: Bool) {
        let item = UIBarButtonItem(title: "Purchase", style: .plain, target: self, action: Selector(("purchaseOrder")))
        var items = [UIBarButtonItem]()
        items.append(item)
        self.setToolbarItems(items, animated: true)
        self.navigationController?.setToolbarHidden(false, animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func btnAdd_Tapped(_ sender: Any) {
        
    }
    
    //MARK: - TABLE VIEW
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        if isTableAvailable {
            return 0
        }
        else {
            return 1
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isTableAvailable {
            return 0
        }
        else {
            return 1
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MainTableDetailTableViewCell", for: indexPath) as! MainTableDetailTableViewCell

        cell.lblFoodName.text = "Food Name"
        cell.lblPrice.text = "50.000"
        cell.lblQuantity.text = "x3"
        cell.lblAmount.text = "150.000"

        return cell
    }
    
    /*
    //MARK: - NAVIGATION
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
}
