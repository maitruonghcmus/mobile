//
//  OrderDetailContext.swift
//  Midterm
//
//  Created by An Le on 4/27/17.
//  Copyright © 2017 IMIT. All rights reserved.
//

import Foundation

class OrderDetailContext: NSObject {
    let tableName = "orderdetail"
    func insert(value: OrderDetail) -> OrderDetail {
        let dbPointer = MySqlite.open()
        let query = "INSERT INTO \(tableName) (orderid, sequencenumber, menuitemid, quantity, amount) VALUES (?, ?, ?, ?, ?);"
        var sqlPointer : OpaquePointer? = nil
        if sqlite3_prepare_v2(dbPointer, query, -1, &sqlPointer, nil) == SQLITE_OK {
            sqlite3_bind_int(sqlPointer, 1, Int32(value.OrderId))
            sqlite3_bind_int(sqlPointer, 2, Int32(value.SequenceNumber))
            sqlite3_bind_int(sqlPointer, 3, Int32(value.MenuItemId))
            sqlite3_bind_int(sqlPointer, 4, Int32(value.Quantity))
            sqlite3_bind_text(sqlPointer, 5, String(format: "%f", value.Amount).cString(using: .utf8), -1, SQLITE_TRANSIENT)
            if sqlite3_step(sqlPointer) == SQLITE_DONE {
                value.OrderId = Int(sqlite3_last_insert_rowid(dbPointer))
                print("sql create \(tableName) success")
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
    func update(value: OrderDetail) -> Bool {
        var result = false
        let dbPointer = MySqlite.open()
        let query = "UPDATE \(tableName) SET orderid=?, sequencenumber=?, menuitemid=?, quantity=?, amount=? WHERE id = ?;"
        var sqlPointer : OpaquePointer? = nil
        if sqlite3_prepare_v2(dbPointer, query, -1, &sqlPointer, nil) == SQLITE_OK {
            sqlite3_bind_int(sqlPointer, 1, Int32(value.OrderId))
            sqlite3_bind_int(sqlPointer, 2, Int32(value.SequenceNumber))
            sqlite3_bind_int(sqlPointer, 3, Int32(value.MenuItemId))
            sqlite3_bind_int(sqlPointer, 4, Int32(value.Quantity))
            sqlite3_bind_text(sqlPointer, 5, String(format: "%f", value.Amount).cString(using: .utf8), -1, SQLITE_TRANSIENT)
            sqlite3_bind_int(sqlPointer, 6, Int32(value.Id))
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
    func all() -> [OrderDetail] {
        var result = [OrderDetail]()
        let dbPointer = MySqlite.open()
        let query = "SELECT id, orderid, sequencenumber, menuitemid, quantity, amount FROM \(tableName);"
        var sqlPointer : OpaquePointer? = nil
        if sqlite3_prepare_v2(dbPointer, query, -1, &sqlPointer, nil) == SQLITE_OK {
            while sqlite3_step(sqlPointer) == SQLITE_ROW {
                let value = OrderDetail(Id: Int(sqlite3_column_int(sqlPointer, 0)),
                                  OrderId: Int(sqlite3_column_int(sqlPointer, 1)),
                                  Order: Order(),
                                  SequenceNumber: Int(sqlite3_column_int(sqlPointer, 3)),
                                  MenuItemId: Int(sqlite3_column_int(sqlPointer, 4)),
                                  MenuItem: MenuItem(),
                                  Quantity: Int(sqlite3_column_int(sqlPointer, 5)),
                                  Amount: Double(String(cString: sqlite3_column_text(sqlPointer, 6)!))!)
                value.Order = DataContext.Instance.Orders.get(id: value.OrderId)
                value.MenuItem = DataContext.Instance.MenuItems.get(id: value.MenuItemId)
                result.append(value)
                print("select \(tableName) success")
            }
        }
        else {
            print("query all \(tableName) not ok")
        }
        sqlite3_finalize(sqlPointer)
        sqlite3_close(dbPointer)
        return result
    }
    func get(id: Int) -> OrderDetail {
        var result = OrderDetail()
        let dbPointer = MySqlite.open()
        let query = "SELECT id, orderid, sequencenumber, menuitemid, quantity, amount FROM \(tableName) WHERE id=?;"
        var sqlPointer : OpaquePointer? = nil
        if sqlite3_prepare_v2(dbPointer, query, -1, &sqlPointer, nil) == SQLITE_OK {
            sqlite3_bind_int(sqlPointer, 1, Int32(id))
            if sqlite3_step(sqlPointer) == SQLITE_DONE {
                result = OrderDetail(Id: Int(sqlite3_column_int(sqlPointer, 0)),
                                     OrderId: Int(sqlite3_column_int(sqlPointer, 1)),
                                     Order: Order(),
                                     SequenceNumber: Int(sqlite3_column_int(sqlPointer, 3)),
                                     MenuItemId: Int(sqlite3_column_int(sqlPointer, 4)),
                                     MenuItem: MenuItem(),
                                     Quantity: Int(sqlite3_column_int(sqlPointer, 5)),
                                     Amount: Double(String(cString: sqlite3_column_text(sqlPointer, 6)!))!)
                result.Order = DataContext.Instance.Orders.get(id: result.OrderId)
                result.MenuItem = DataContext.Instance.MenuItems.get(id: result.MenuItemId)
                print("select one \(tableName) success")
            }
        }
        else {
            print("query one \(tableName) not ok")
        }
        sqlite3_finalize(sqlPointer)
        sqlite3_close(dbPointer)
        return result
    }
}
