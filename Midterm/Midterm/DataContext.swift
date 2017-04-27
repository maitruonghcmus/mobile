//
//  AppContext.swift
//  Midterm
//
//  Created by Truong Mai on 4/18/17.
//  Copyright © 2017 IMIT. All rights reserved.
//

import UIKit

import Foundation

final class DataContext {
    
    static let Instance = DataContext()
    
    private init(){
        InitData()
    }
    
    //MARK: *** Data Models Context
    
    var Tables = TableContext()
    var Areas = AreaContext()
    var Images = ImageContext()
    var MenuItems = MenuItemContext()
    
    
    //MARK: *** Data Models
    

    
    func InitData(){
        //TODO: Load all data from databale to these objects
        
        MySqlite.createTable()
    }
    
}
