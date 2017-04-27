//
//  Table.swift
//  Midterm
//
//  Created by Truong Mai on 4/17/17.
//  Copyright © 2017 IMIT. All rights reserved.
//

import UIKit

public class Table: NSObject {
    var Id: Int = 0
    var Name: String = ""
    var Description: String = ""
    var Images: [Image] = []
    
    //var AreaId: Int = 0
    var Area : Area?
    
    var TableStatus: Int = 0
    //0 = Available
    //1 = Unavailable
    
    override init(){
    }
    
    init(Id:Int,Name:String,Description:String,Images:[Image], Area:Area, TableStatus: Int) {
        self.Id = Id
        self.Name = Name
        self.Description = Description
        self.Images = Images
        self.Area = Area
        self.TableStatus = TableStatus
    }

}
