//
//  Food.swift
//  Midterm
//
//  Created by Truong Mai on 4/17/17.
//  Copyright © 2017 IMIT. All rights reserved.
//

import UIKit

enum MenuItemType : Int {
    case Food = 1
    case Drink = 2
}

//Menu Item = Mon An
class MenuItem: NSObject {
    var Id: Int = 0
    var Name: String = ""
    var Price: Decimal = 0.0
    var Description: String = ""
    var Images: [String] = []
    
    var MenuItemType: Int = 1
    //Food = 1
    //Drink = 2
    
    
}
