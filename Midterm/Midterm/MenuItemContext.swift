//
//  MenuItemContext.swift
//  Midterm
//
//  Created by An Le on 4/26/17.
//  Copyright © 2017 IMIT. All rights reserved.
//

import Foundation

class MenuItemContext {
    func insert(value: MenuItem) -> MenuItem {
        let result = value
        let dbPointer = MySqlite.open()
        let query = "INSERT INTO menuitem (name, price, description, menuitemtype) VALUES (?, ?, ?, ?);"
        var sqlPointer : OpaquePointer? = nil
        if sqlite3_prepare_v2(dbPointer, query, -1, &sqlPointer, nil) == SQLITE_OK {
            sqlite3_bind_text(sqlPointer, 1, value.Name.cString(using: .utf8), -1, SQLITE_TRANSIENT)
            sqlite3_bind_text(sqlPointer, 2, String(format: "%f", value.Price as CVarArg).cString(using: .utf8), -1, SQLITE_TRANSIENT)
            sqlite3_bind_text(sqlPointer, 3, value.Description.cString(using: .utf8), -1, SQLITE_TRANSIENT)
            sqlite3_bind_int(sqlPointer, 4, Int32(value.MenuItemType))
            if sqlite3_step(sqlPointer) == SQLITE_DONE {
                let id = sqlite3_last_insert_rowid(sqlPointer)
                result.Id = Int(id)
                print("created menuitem success")
                
            }
            else {
                print("create menuitem fail")
            }
        }
        else {
            print("query create menuitem not ok")
        }
        sqlite3_finalize(sqlPointer)
        sqlite3_close(dbPointer)
        return result
    }
    func update(value: MenuItem) {
        let dbPointer = MySqlite.open()
        let query = "UPDATE menuitem SET name = ?, price = ?, description = ?, meuitemtype = ? WHERE id = ?;"
        var sqlPointer : OpaquePointer? = nil
        if sqlite3_prepare_v2(dbPointer, query, -1, &sqlPointer, nil) == SQLITE_OK {
            sqlite3_bind_text(sqlPointer, 1, value.Name.cString(using: .utf8), -1, SQLITE_TRANSIENT)
            sqlite3_bind_text(sqlPointer, 2, String(format: "%f", value.Price as CVarArg).cString(using: .utf8), -1, SQLITE_TRANSIENT)
            sqlite3_bind_text(sqlPointer, 3, value.Description.cString(using: .utf8), -1, SQLITE_TRANSIENT)
            sqlite3_bind_int(sqlPointer, 4, Int32(value.MenuItemType))
            sqlite3_bind_int(sqlPointer, 5, Int32(value.Id))
            if sqlite3_step(sqlPointer) == SQLITE_DONE {
                print("updated menuitem success")
            }
            else {
                print("update menuitem fail")
            }
        }
        else {
            print("query update menuitem not ok")
        }
        sqlite3_finalize(sqlPointer)
        sqlite3_close(dbPointer)
    }
    func delete(id: Int) {
        let dbPointer = MySqlite.open()
        let query = "DELETE FROM menuitem WHERE id = ?;"
        var sqlPointer : OpaquePointer? = nil
        if sqlite3_prepare_v2(dbPointer, query, -1, &sqlPointer, nil) == SQLITE_OK {
            sqlite3_bind_int(sqlPointer, 1, Int32(id))
            if sqlite3_step(sqlPointer) == SQLITE_DONE {
                print("delete menuitem success")
            }
            else {
                print("delete menuitem success")
            }
        }
        else {
            print("query delete menuitem not ok")
        }
        sqlite3_finalize(sqlPointer)
        sqlite3_close(dbPointer)
    }
    func all() -> [MenuItem] {
        var result = [MenuItem]()
        let dbPointer = MySqlite.open()
        let query = "SELECT id, name, price, description, menuitemtype FROM menuitem;"
        var sqlPointer : OpaquePointer? = nil
        if sqlite3_prepare_v2(dbPointer, query, -1, &sqlPointer, nil) == SQLITE_OK {
            while sqlite3_step(sqlPointer) == SQLITE_ROW {
                let item = MenuItem(Id: Int(sqlite3_column_int(sqlPointer, 0)),
                                  Name: String(cString: sqlite3_column_text(sqlPointer, 1)!),
                                  Description: String(cString: sqlite3_column_text(sqlPointer, 2)!),
                                  Price: Double(String(cString: sqlite3_column_text(sqlPointer, 3)!))!,
                                  Images: [String](),
                                  MenuItemType: Int(sqlite3_column_int(sqlPointer, 4)))
                print("select area success")
                result.append(item)
            }
        }
        else {
            print("query all area not ok")
        }
        sqlite3_finalize(sqlPointer)
        sqlite3_close(dbPointer)
        return result
    }
    func get(id: Int) -> MenuItem {
        var result = MenuItem()
        let dbPointer = MySqlite.open()
        let query = "SELECT id, name, price, description, menuitemtype FROM menuitem WHERE id=?;"
        var sqlPointer : OpaquePointer? = nil
        if sqlite3_prepare_v2(dbPointer, query, -1, &sqlPointer, nil) == SQLITE_OK {
            sqlite3_bind_int(sqlPointer, 1, Int32(id))
            if sqlite3_step(sqlPointer) == SQLITE_DONE {
                result = MenuItem(Id: Int(sqlite3_column_int(sqlPointer, 0)),
                                  Name: String(cString: sqlite3_column_text(sqlPointer, 1)!),
                                  Description: String(cString: sqlite3_column_text(sqlPointer, 2)!),
                                  Price: Double(String(cString: sqlite3_column_text(sqlPointer, 3)!))!,
                                  Images: [String](),
                                  MenuItemType: Int(sqlite3_column_int(sqlPointer, 4)))
                print("select one menuitem success")
                
            }
            else {
                print("select one menuitem fail")
            }
        }
        else {
            print("query one area menuitem ok")
        }
        sqlite3_finalize(sqlPointer)
        sqlite3_close(dbPointer)
        return result
    }
    
}
