//
//  Area.swift
//  Midterm
//
//  Created by Truong Mai on 4/17/17.
//  Copyright © 2017 IMIT. All rights reserved.
//

import UIKit

public class Area: NSObject {
    var Id: Int = 0
    var Name: String = ""
    var Description: String = ""
    var Images: [Image] = []
    
    override init(){
    }
    
    init(Id:Int,Name:String,Description:String,Images:[Image]) {
        self.Id = Id
        self.Name = Name
        self.Description = Description
        self.Images = Images
    }
}
