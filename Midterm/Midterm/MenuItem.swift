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
    var Price: Double = 0.0
    var Description: String = ""
    var Images: [String] = []
    
    var MenuItemType: Int = 1
    //Food = 1
    //Drink = 2
    
    override init(){
        
    }
    
    init(Id:Int,Name:String,Description:String,Price:Double,Images:[String], MenuItemType: Int) {
        self.Id = Id
        self.Name = Name
        self.Description = Description
        self.Price = Price
        self.Images = Images
        self.MenuItemType = MenuItemType
    }
}
