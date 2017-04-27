//
//  OrderContext.swift
//  Midterm
//
//  Created by An Le on 4/27/17.
//  Copyright © 2017 IMIT. All rights reserved.
//

import Foundation

class OrderContext: NSObject {
    let tableName = "order"
    func insert(value: Order) -> Order {
        let dbPointer = MySqlite.open()
        let query = "INSERT INTO \(tableName) (orderdate, customer, tableid, total, currency, status) VALUES (?, ?, ?, ?, ?, ?);"
        var sqlPointer : OpaquePointer? = nil
        if sqlite3_prepare_v2(dbPointer, query, -1, &sqlPointer, nil) == SQLITE_OK {
            sqlite3_bind_text(sqlPointer, 1, AppUtils.formatDate(date: value.OrderDate).cString(using: .utf8), -1, SQLITE_TRANSIENT)
            sqlite3_bind_text(sqlPointer, 2, value.Customer.cString(using: .utf8), -1, SQLITE_TRANSIENT)
            sqlite3_bind_int(sqlPointer, 3, Int32(value.TableId))
            sqlite3_bind_text(sqlPointer, 4, String(format: "%f", value.Total).cString(using: .utf8), -1, SQLITE_TRANSIENT)
            sqlite3_bind_int(sqlPointer, 5, Int32(value.Currency))
            sqlite3_bind_int(sqlPointer, 6, Int32(value.Status))
            if sqlite3_step(sqlPointer) == SQLITE_DONE {
                value.Id = Int(sqlite3_last_insert_rowid(dbPointer))
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
    func update(value: Order) -> Bool {
        var result = false
        let dbPointer = MySqlite.open()
        let query = "UPDATE \(tableName) SET orderdate = ?, customer = ?, tableid = ?, total = ?, currency = ?, status = ? WHERE id = ?;"
        var sqlPointer : OpaquePointer? = nil
        if sqlite3_prepare_v2(dbPointer, query, -1, &sqlPointer, nil) == SQLITE_OK {
            sqlite3_bind_text(sqlPointer, 1, AppUtils.formatDate(date: value.OrderDate).cString(using: .utf8), -1, SQLITE_TRANSIENT)
            sqlite3_bind_text(sqlPointer, 2, value.Customer.cString(using: .utf8), -1, SQLITE_TRANSIENT)
            sqlite3_bind_int(sqlPointer, 3, Int32(value.TableId))
            sqlite3_bind_text(sqlPointer, 4, String(format: "%f", value.Total).cString(using: .utf8), -1, SQLITE_TRANSIENT)
            sqlite3_bind_int(sqlPointer, 5, Int32(value.Currency))
            sqlite3_bind_int(sqlPointer, 6, Int32(value.Status))
            sqlite3_bind_int(sqlPointer, 7, Int32(value.Id))
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
    func all() -> [Order] {
        var result = [Order]()
        let dbPointer = MySqlite.open()
        let query = "SELECT id, orderdate, customer, tableid, total, currency, status FROM \(tableName);"
        var sqlPointer : OpaquePointer? = nil
        if sqlite3_prepare_v2(dbPointer, query, -1, &sqlPointer, nil) == SQLITE_OK {
            while sqlite3_step(sqlPointer) == SQLITE_ROW {
                let value = Order(Id: Int(sqlite3_column_int(sqlPointer, 0)),
                                  OrderDate: AppUtils.formatString(string: String(cString: sqlite3_column_text(sqlPointer, 1)!)),
                                  Customer: String(cString: sqlite3_column_text(sqlPointer, 2)!),
                                  TableId: Int(sqlite3_column_int(sqlPointer, 3)),
                                  Table: Table(),
                                  Total: Double(String(cString: sqlite3_column_text(sqlPointer, 4)!))!,
                                  Currency: Int(sqlite3_column_int(sqlPointer, 5)),
                                  Status: Int(sqlite3_column_int(sqlPointer, 6)))
                value.Table = DataContext.Instance.Tables.get(id: value.TableId)
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
    func all(status: Int) -> [Order] {
        var result = [Order]()
        let dbPointer = MySqlite.open()
        let query = "SELECT id, orderdate, customer, tableid, total, currency, status FROM \(tableName) WHERE Status = ?;"
        var sqlPointer : OpaquePointer? = nil
        if sqlite3_prepare_v2(dbPointer, query, -1, &sqlPointer, nil) == SQLITE_OK {
            sqlite3_bind_int(sqlPointer, 1, Int32(status))
            while sqlite3_step(sqlPointer) == SQLITE_ROW {
                let value = Order(Id: Int(sqlite3_column_int(sqlPointer, 0)),
                                  OrderDate: AppUtils.formatString(string: String(cString: sqlite3_column_text(sqlPointer, 1)!)),
                                  Customer: String(cString: sqlite3_column_text(sqlPointer, 2)!),
                                  TableId: Int(sqlite3_column_int(sqlPointer, 3)),
                                  Table: Table(),
                                  Total: Double(String(cString: sqlite3_column_text(sqlPointer, 4)!))!,
                                  Currency: Int(sqlite3_column_int(sqlPointer, 5)),
                                  Status: Int(sqlite3_column_int(sqlPointer, 6)))
                value.Table = DataContext.Instance.Tables.get(id: value.TableId)
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
    func get(id: Int) -> Order {
        var result = Order()
        let dbPointer = MySqlite.open()
        let query = "SELECT id, orderdate, customer, tableid, total, currency, status FROM \(tableName) WHERE id=?;"
        var sqlPointer : OpaquePointer? = nil
        if sqlite3_prepare_v2(dbPointer, query, -1, &sqlPointer, nil) == SQLITE_OK {
            sqlite3_bind_int(sqlPointer, 1, Int32(id))
            if sqlite3_step(sqlPointer) == SQLITE_DONE {
                result = Order(Id: Int(sqlite3_column_int(sqlPointer, 0)),
                               OrderDate: AppUtils.formatString(string: String(cString: sqlite3_column_text(sqlPointer, 1)!)),
                               Customer: String(cString: sqlite3_column_text(sqlPointer, 2)!),
                               TableId: Int(sqlite3_column_int(sqlPointer, 3)),
                               Table: Table(),
                               Total: Double(String(cString: sqlite3_column_text(sqlPointer, 4)!))!,
                               Currency: Int(sqlite3_column_int(sqlPointer, 5)),
                               Status: Int(sqlite3_column_int(sqlPointer, 6)))
                result.Table = DataContext.Instance.Tables.get(id: result.TableId)
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
    func getByTableFree(id: Int) -> Order {
        var result = Order()
        let dbPointer = MySqlite.open()
        let query = "SELECT id, orderdate, customer, tableid, total, currency, status FROM \(tableName) WHERE tableid=? AND status=0;"
        var sqlPointer : OpaquePointer? = nil
        if sqlite3_prepare_v2(dbPointer, query, -1, &sqlPointer, nil) == SQLITE_OK {
            sqlite3_bind_int(sqlPointer, 1, Int32(id))
            if sqlite3_step(sqlPointer) == SQLITE_DONE {
                result = Order(Id: Int(sqlite3_column_int(sqlPointer, 0)),
                               OrderDate: AppUtils.formatString(string: String(cString: sqlite3_column_text(sqlPointer, 1)!)),
                               Customer: String(cString: sqlite3_column_text(sqlPointer, 2)!),
                               TableId: Int(sqlite3_column_int(sqlPointer, 3)),
                               Table: Table(),
                               Total: Double(String(cString: sqlite3_column_text(sqlPointer, 4)!))!,
                               Currency: Int(sqlite3_column_int(sqlPointer, 5)),
                               Status: Int(sqlite3_column_int(sqlPointer, 6)))
                result.Table = DataContext.Instance.Tables.get(id: result.TableId)
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
