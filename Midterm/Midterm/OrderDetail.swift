//
//  OrderDetail.swift
//  Midterm
//
//  Created by Truong Mai on 4/17/17.
//  Copyright © 2017 IMIT. All rights reserved.
//

import UIKit

class OrderDetail: NSObject {
    var Id : Int = 0
    var OrderId: Int = 0
    var Order : Order?
    var SequenceNumber: Int = 1
    
    var MenuItemId: Int = 0
    var MenuItem: MenuItem?
    
    var Quantity: Int = 1
    
    var Amount: Double = 0
    override init(){}
    init(Id: Int,OrderId: Int,Order:Order,SequenceNumber: Int, MenuItemId: Int, MenuItem: MenuItem, Quantity:Int, Amount: Double){
        self.Id = Id
        self.Order = Order
        self.OrderId = OrderId
        self.SequenceNumber = SequenceNumber
        self.MenuItemId = MenuItemId
        self.MenuItem = MenuItem
        self.Quantity = Quantity
        self.Amount = Amount
    }
}
