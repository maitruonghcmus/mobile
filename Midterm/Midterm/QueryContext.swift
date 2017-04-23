//
//  DataContext.swift
//  Midterm
//
//  Created by Truong Mai on 4/18/17.
//  Copyright © 2017 IMIT. All rights reserved.
//

import UIKit

import Foundation

final class QueryContext {
    
    static let Instance = QueryContext()
    
    private init(){
        
    }
    
    func Insert<T>(object: T) -> Bool {
        //TODO: implement insert object to database
        return true
    }
    
    func Update<T>(object: T) -> Bool {
        //TODO: implement update object to database
        return true
    }
    
    func Delete<T>(object: T) -> Bool {
        //TODO: implement delete object from database
        return true
    }
    
    func SelectAll<T>() -> [T]? {
        //TODO: implement select all from database
        return nil
    }
    
    func Select<T>(id: Int) -> T? {
        //TODOL implement select where id from database
        return nil
    }
}
