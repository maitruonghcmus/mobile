//
//  Image.swift
//  Midterm
//
//  Created by An Le on 4/26/17.
//  Copyright © 2017 IMIT. All rights reserved.
//

import UIKit

class Image: NSObject {
    var Id: Int = 0
    var Area: Area?
    var Table: Table?
    var MenuItem: MenuItem?
    var Path : String = ""
    override init(){
        
    }
    init(Id: Int, Area: Area, Table: Table, MenuItem: MenuItem, Path: String){
        self.Id = Id
        self.Area = Area
        self.Table = Table
        self.MenuItem = MenuItem
        self.Path = Path
    }
}
