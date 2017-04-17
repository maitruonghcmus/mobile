//
//  Order.swift
//  Midterm
//
//  Created by Truong Mai on 4/17/17.
//  Copyright © 2017 IMIT. All rights reserved.
//

import UIKit

enum Currency: Int {
    case VND = 0
    case USD = 1
}

class Order: NSObject {
    var Id:Int = 0
    var OrderDate: Date = Date()
    var Customer: String = ""
    
    var TableId: Int = 0
    var Table: Table?
    
    var Total: Decimal = 0.0
    
    var Currency: Int = 0
    //VND = 0
    //USD = 1
}
