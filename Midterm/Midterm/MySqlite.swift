//
//  MySqlite.swift
//  BT1
//
//  Created by An Le on 4/1/17.
//  Copyright © 2017 An Le. All rights reserved.
//

import Foundation

let SQLITE_TRANSIENT = unsafeBitCast(OpaquePointer(bitPattern: -1), to: sqlite3_destructor_type.self)

public class MySqlite {
    static var dbName = "restaurent.db"
    static func open() -> OpaquePointer? {
        var dbPointer : OpaquePointer? = nil
        let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let url = dir.appendingPathComponent("\(dbName)").path
        print(url)
        if sqlite3_open(url, &dbPointer) == SQLITE_OK {
            print("Success open connection")
            return dbPointer
        }
        else {
            print("Fail open connection")
            return nil
        }
    }
    static func createTable() {
        let list : [(String,String)] = [
            ("area","CREATE TABLE IF NOT EXISTS area (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, description TEXT);"),
            ("table","CREATE TABLE IF NOT EXISTS table (id INTEGER PRIMARY KEY AUTOINCREMENT, description TEXT, areaid INTEGER, tablestatus INTEGER);"),
            ("image","CREATE TABLE IF NOT EXISTS image (id INTEGER PRIMARY KEY AUTOINCREMENT, areaid INTEGER, tableid INTEGER, menuitemid INTEGER, path TEXT);"),
            ("menuitem","CREATE TABLE IF NOT EXISTS menuitem (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, price TEXT, description TEXT, menuitemtype INTEGER);")
                    ]
        let dbPointer = open()
        var sqlPointer : OpaquePointer? = nil
        for (table, query) in list {
            if sqlite3_prepare_v2(dbPointer, query, -1, &sqlPointer, nil) == SQLITE_OK {
                if sqlite3_step(sqlPointer) == SQLITE_DONE {
                    print("created \(table) area")
                }
                else {
                    print("create \(table) area fail")
                }
            }
            else {
                print("query create \(table) student not ok")
            }
            sqlite3_reset(sqlPointer)
        }
        sqlite3_finalize(sqlPointer)
        sqlite3_close(dbPointer)
    }
}
