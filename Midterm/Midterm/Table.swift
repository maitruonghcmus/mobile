//
//  Table.swift
//  Midterm
//
//  Created by Truong Mai on 4/17/17.
//  Copyright © 2017 IMIT. All rights reserved.
//

import UIKit

//enum TableStatus: Int {
//    case Unavailable = 0
//    case Available = 1
//}

class Table: NSObject {
    var Id: Int = 0
    var Description: String = ""
    var Images: [String] = []
    
    //var AreaId: Int = 0
    var Area : Area?
    
    var TableStatus: Int = 1
    //0 = Available
    //1 = Unavailable
}
