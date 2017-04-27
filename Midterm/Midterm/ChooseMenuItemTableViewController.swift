//
//  ChooseMenuItemTableViewController.swift
//  Midterm
//
//  Created by An Le on 4/27/17.
//  Copyright © 2017 IMIT. All rights reserved.
//

import Foundation

import UIKit

protocol ReloadTableDelegate {
    func reload(order: Order)
}

class ChooseMenuItemTableViewController: UITableViewController {
    
    //MARK: - VARIABLE
    var menuitems = [MenuItem]()
    var order = Order()
    var table = Table()
    var delegate : ReloadTableDelegate? = nil
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
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = menuitems[indexPath.row]
        if order.Id == 0 {
            order = Order(Id: 0, OrderDate: Date(), Customer: "", TableId: table.Id, Table: table, Total: item.Price, Currency: 0, Status: 0)
            order = DataContext.Instance.Orders.insert(value: order)
        }
        let detail = OrderDetail(Id: 0, OrderId: order.Id, Order: order, SequenceNumber: 1, MenuItemId: item.Id, MenuItem: item, Quantity: 1, Amount: item.Price)
        if DataContext.Instance.OrderDetails.insert(value: detail).Id != 0 {
            delegate?.reload(order: order)
        }else {
            AppUtils.DisplayAlertMessage(title: "Error", message: "some error occurred", controller: self)
        }
    }
}
