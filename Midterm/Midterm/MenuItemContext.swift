//
//  MenuItemContext.swift
//  Midterm
//
//  Created by An Le on 4/26/17.
//  Copyright © 2017 IMIT. All rights reserved.
//

import Foundation

class MenuItemContext {
    let tableName = "menuitem"
    func insert(value: MenuItem) -> MenuItem {
        let dbPointer = MySqlite.open()
        let query = "INSERT INTO \(tableName) (name, price, description, menuitemtype) VALUES (?, ?, ?, ?);"
        var sqlPointer : OpaquePointer? = nil
        if sqlite3_prepare_v2(dbPointer, query, -1, &sqlPointer, nil) == SQLITE_OK {
            sqlite3_bind_text(sqlPointer, 1, value.Name.cString(using: .utf8), -1, SQLITE_TRANSIENT)
            sqlite3_bind_text(sqlPointer, 2, String(format: "%f", value.Price).cString(using: .utf8), -1, SQLITE_TRANSIENT)
            sqlite3_bind_text(sqlPointer, 3, value.Description.cString(using: .utf8), -1, SQLITE_TRANSIENT)
            sqlite3_bind_int(sqlPointer, 4, Int32(value.MenuItemType))
            if sqlite3_step(sqlPointer) == SQLITE_DONE {
                value.Id = Int(sqlite3_last_insert_rowid(dbPointer))
                print("created \(tableName) success")
                
            }
            else {
                print("create \(tableName) fail")
            }
        }
        else {
            print("query create \(tableName) not ok")
        }
        sqlite3_finalize(sqlPointer)
        sqlite3_close(dbPointer)
        return value
    }
    func update(value: MenuItem) -> Bool {
        var result = false
        let dbPointer = MySqlite.open()
        let query = "UPDATE \(tableName) SET name = ?, price = ?, description = ?, meuitemtype = ? WHERE id = ?;"
        var sqlPointer : OpaquePointer? = nil
        if sqlite3_prepare_v2(dbPointer, query, -1, &sqlPointer, nil) == SQLITE_OK {
            sqlite3_bind_text(sqlPointer, 1, value.Name.cString(using: .utf8), -1, SQLITE_TRANSIENT)
            sqlite3_bind_text(sqlPointer, 2, String(format: "%f", value.Price as CVarArg).cString(using: .utf8), -1, SQLITE_TRANSIENT)
            sqlite3_bind_text(sqlPointer, 3, value.Description.cString(using: .utf8), -1, SQLITE_TRANSIENT)
            sqlite3_bind_int(sqlPointer, 4, Int32(value.MenuItemType))
            sqlite3_bind_int(sqlPointer, 5, Int32(value.Id))
            if sqlite3_step(sqlPointer) == SQLITE_DONE {
                print("updated \(tableName) success")
                result = true
            }
            else {
                print("update \(tableName) fail")
            }
        }
        else {
            print("query update \(tableName) not ok")
        }
        sqlite3_finalize(sqlPointer)
        sqlite3_close(dbPointer)
        return result
    }
    func delete(id: Int) -> Bool {
        var result = false
        let dbPointer = MySqlite.open()
        let query = "DELETE FROM \(tableName) WHERE id = ?;"
        var sqlPointer : OpaquePointer? = nil
        if sqlite3_prepare_v2(dbPointer, query, -1, &sqlPointer, nil) == SQLITE_OK {
            sqlite3_bind_int(sqlPointer, 1, Int32(id))
            if sqlite3_step(sqlPointer) == SQLITE_DONE {
                print("delete \(tableName) success")
                result = true
            }
            else {
                print("delete \(tableName) success")
            }
        }
        else {
            print("query delete \(tableName) not ok")
        }
        sqlite3_finalize(sqlPointer)
        sqlite3_close(dbPointer)
        return result
    }
    func all() -> [MenuItem] {
        var result = [MenuItem]()
        let dbPointer = MySqlite.open()
        let query = "SELECT id, name, description, price, menuitemtype FROM \(tableName);"
        var sqlPointer : OpaquePointer? = nil
        if sqlite3_prepare_v2(dbPointer, query, -1, &sqlPointer, nil) == SQLITE_OK {
            while sqlite3_step(sqlPointer) == SQLITE_ROW {
                let value = MenuItem(Id: Int(sqlite3_column_int(sqlPointer, 0)),
                                  Name: String(cString: sqlite3_column_text(sqlPointer, 1)!),
                                  Description: String(cString: sqlite3_column_text(sqlPointer, 2)!),
                                  Price: Double(String(cString: sqlite3_column_text(sqlPointer, 3)!))!,
                                  Images: [Image](),
                                  MenuItemType: Int(sqlite3_column_int(sqlPointer, 4)))
                value.Images = DataContext.Instance.Images.all(id: value.Id, tables: .MENUITEM)
                print("select \(tableName) success")
                result.append(value)
            }
        }
        else {
            print("query all \(tableName) not ok")
        }
        sqlite3_finalize(sqlPointer)
        sqlite3_close(dbPointer)
        return result
    }
    func get(id: Int) -> MenuItem {
        var result = MenuItem()
        let dbPointer = MySqlite.open()
        let query = "SELECT id, name, description, price, menuitemtype FROM menuitem WHERE id=?;"
        var sqlPointer : OpaquePointer? = nil
        if sqlite3_prepare_v2(dbPointer, query, -1, &sqlPointer, nil) == SQLITE_OK {
            sqlite3_bind_int(sqlPointer, 1, Int32(id))
            if sqlite3_step(sqlPointer) == SQLITE_DONE {
                result = MenuItem(Id: Int(sqlite3_column_int(sqlPointer, 0)),
                                  Name: String(cString: sqlite3_column_text(sqlPointer, 1)!),
                                  Description: String(cString: sqlite3_column_text(sqlPointer, 2)!),
                                  Price: Double(String(cString: sqlite3_column_text(sqlPointer, 3)!))!,
                                  Images: [Image](),
                                  MenuItemType: Int(sqlite3_column_int(sqlPointer, 4)))
                result.Images = DataContext.Instance.Images.all(id: result.Id, tables: .MENUITEM)
                print("select one \(tableName) success")
                
            }
            else {
                print("select one \(tableName) fail")
            }
        }
        else {
            print("query one area \(tableName) ok")
        }
        sqlite3_finalize(sqlPointer)
        sqlite3_close(dbPointer)
        return result
    }
    
}
