//
//  TableContext.swift
//  Midterm
//
//  Created by An Le on 4/25/17.
//  Copyright © 2017 IMIT. All rights reserved.
//

import UIKit

class TableContext: NSObject {
    let tableName = "tables"
    func insert(value: Table) -> Table {
        let dbPointer = MySqlite.open()
        let query = "INSERT INTO \(tableName) (name, description, areaid, tablestatus) VALUES (?, ?, ?, ?);"
        var sqlPointer : OpaquePointer? = nil
        if sqlite3_prepare_v2(dbPointer, query, -1, &sqlPointer, nil) == SQLITE_OK {
            sqlite3_bind_text(sqlPointer, 1, value.Name.cString(using: .utf8), -1, SQLITE_TRANSIENT)
            sqlite3_bind_text(sqlPointer, 2, value.Description.cString(using: .utf8), -1, SQLITE_TRANSIENT)
            sqlite3_bind_int(sqlPointer, 3, Int32((value.Area?.Id)!))
            sqlite3_bind_int(sqlPointer, 4, Int32(value.TableStatus))
            if sqlite3_step(sqlPointer) == SQLITE_DONE {
                value.Id = Int(sqlite3_last_insert_rowid(dbPointer))
                for image in value.Images {
                    if  DataContext.Instance.Images.insert(value:
                        Image(Id: 0, Area: Area(), Table: value, MenuItem: MenuItem(), Path: image.Path))
                        .Id != 0 {
                        print("sql create \(tableName) image success")
                    } else {
                        print("sql create \(tableName) image fail")
                    }
                }
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
    func update(value: Table) -> Bool {
        var result = false
        let dbPointer = MySqlite.open()
        let query = "UPDATE \(tableName) SET name = ?, description = ?, areaid = ?, tablestatus = ? WHERE id = ?;"
        var sqlPointer : OpaquePointer? = nil
        if sqlite3_prepare_v2(dbPointer, query, -1, &sqlPointer, nil) == SQLITE_OK {
            sqlite3_bind_text(sqlPointer, 1, value.Name.cString(using: .utf8), -1, SQLITE_TRANSIENT)
            sqlite3_bind_text(sqlPointer, 2, value.Description.cString(using: .utf8), -1, SQLITE_TRANSIENT)
            sqlite3_bind_int(sqlPointer, 3, Int32((value.Area?.Id)!))
            sqlite3_bind_int(sqlPointer, 4, Int32(value.TableStatus))
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
    func all() -> [Table] {
        var result = [Table]()
        let dbPointer = MySqlite.open()
        let query = "SELECT id, name, description, areaid, tablestatus FROM \(tableName);"
        var sqlPointer : OpaquePointer? = nil
        if sqlite3_prepare_v2(dbPointer, query, -1, &sqlPointer, nil) == SQLITE_OK {
            while sqlite3_step(sqlPointer) == SQLITE_ROW {
                let value = Table(Id: Int(sqlite3_column_int(sqlPointer, 0)),
                                  Name: String(cString: sqlite3_column_text(sqlPointer, 1)!),
                                  Description: String(cString: sqlite3_column_text(sqlPointer, 2)!),
                                  Images: [Image](),
                                  Area: Area(),
                                  TableStatus: Int(sqlite3_column_int(sqlPointer, 4)))
                value.Area = DataContext.Instance.Areas.get(id: Int(sqlite3_column_int(sqlPointer, 3)))
                value.Images = DataContext.Instance.Images.all(id: value.Id, tables: .TABLE)
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
    func get(id: Int) -> Table {
        var result = Table()
        let dbPointer = MySqlite.open()
        let query = "SELECT id, description, areaid, tablestatus FROM \(tableName) WHERE id=?;"
        var sqlPointer : OpaquePointer? = nil
        if sqlite3_prepare_v2(dbPointer, query, -1, &sqlPointer, nil) == SQLITE_OK {
            sqlite3_bind_int(sqlPointer, 1, Int32(id))
            if sqlite3_step(sqlPointer) == SQLITE_DONE {
                result = Table(Id: Int(sqlite3_column_int(sqlPointer, 0)),
                               Name: String(cString: sqlite3_column_text(sqlPointer, 1)!),
                               Description: String(cString: sqlite3_column_text(sqlPointer, 2)!),
                               Images: [Image](),
                               Area: Area(),
                               TableStatus: Int(sqlite3_column_int(sqlPointer, 4)))
                result.Area = DataContext.Instance.Areas.get(id: Int(sqlite3_column_int(sqlPointer, 3)))
                result.Images = DataContext.Instance.Images.all(id: result.Id, tables: .TABLE)
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
