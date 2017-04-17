//
//  OrderDetail.swift
//  Midterm
//
//  Created by Truong Mai on 4/17/17.
//  Copyright © 2017 IMIT. All rights reserved.
//

import UIKit

class OrderDetail: NSObject {
    var OrderId: Int = 0
    var SequenceNumber: Int = 1
    
    var MenuItemId: Int = 0
    var MenuItem: MenuItem?
    
    var Quantity: Int = 1
    
    var Amount: Decimal = 0
}
