//
//  MainTableTableViewController.swift
//  Midterm
//
//  Created by Truong Mai on 4/27/17.
//  Copyright © 2017 IMIT. All rights reserved.
//

import UIKit

class MainTableDetailTableViewController: UITableViewController,UIPopoverPresentationControllerDelegate, ReloadTableDelegate {

    //MARK: - VARIABLE
    var currentTable = Table()
    var currentOrder = Order()
    var orderDetail = [OrderDetail]()
    var detailSelected = OrderDetail()
    
    func reload(order: Order) {
        currentOrder = order
        orderDetail = DataContext.Instance.OrderDetails.allByOrder(id: currentOrder.Id)
        tableView.reloadData()
    }
    
    @IBOutlet weak var addButton: UIBarButtonItem!
    //MARK: - UI ELEMENT
    
    //MARK: - CUSTOM FUNCTION
    
    //MARK: - UI EVENT
    override func viewWillAppear(_ animated: Bool) {
        let item = UIBarButtonItem(title: "Purchase", style: .plain, target: self, action: Selector(("purchaseOrder")))
        var items = [UIBarButtonItem]()
        items.append(item)
        self.setToolbarItems(items, animated: true)
        self.navigationController?.setToolbarHidden(false, animated: false)
        orderDetail = DataContext.Instance.OrderDetails.allByOrder(id: currentOrder.Id)
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
        return orderDetail.count
        
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MainTableDetailTableViewCell", for: indexPath) as! MainTableDetailTableViewCell

        let detail = orderDetail[indexPath.row]
        let item = detail.MenuItem
        cell.lblFoodName.text = item?.Name
        cell.lblPrice.text = String(format: "%f",(item?.Price)!)
        cell.lblQuantity.text = "x\(detail.Quantity)"
        cell.lblAmount.text = String(format: "%f",((item?.Price)! * Double(detail.Quantity)))

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        detailSelected = orderDetail[indexPath.row]
        performSegue(withIdentifier: "SegueShowDetailID", sender: nil)
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
    
    @IBAction func addClick(_ sender: Any) {
        let popover = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ChooseMenuItemTableViewController") as! ChooseMenuItemTableViewController
        popover.modalPresentationStyle = .popover
        popover.popoverPresentationController?.delegate = self
        popover.preferredContentSize = CGSize(width: 250, height: 250)
        popover.popoverPresentationController?.barButtonItem = addButton
        popover.popoverPresentationController?.permittedArrowDirections = .any
        popover.order = currentOrder
        popover.table = currentTable
        popover.delegate = self
        self.present(popover, animated: true, completion: nil)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SegueShowDetailID" {
            let destination = segue.destination as! OrderDetailViewController
            destination.detail = detailSelected
        }
    }
}
