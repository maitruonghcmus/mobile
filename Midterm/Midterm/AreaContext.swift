//
//  AreaContext.swift
//  Midterm
//
//  Created by An Le on 4/25/17.
//  Copyright © 2017 IMIT. All rights reserved.
//

import UIKit

class AreaContext: NSObject {
    let tableName = "area"
    func insert(value: Area) -> Area {
        let dbPointer = MySqlite.open()
        let query = "INSERT INTO \(tableName) (name, description) VALUES (?, ?);"
        var sqlPointer : OpaquePointer? = nil
        if sqlite3_prepare_v2(dbPointer, query, -1, &sqlPointer, nil) == SQLITE_OK {
            sqlite3_bind_text(sqlPointer, 1, value.Name.cString(using: .utf8), -1, SQLITE_TRANSIENT)
            sqlite3_bind_text(sqlPointer, 2, value.Description.cString(using: .utf8), -1, SQLITE_TRANSIENT)
            if sqlite3_step(sqlPointer) == SQLITE_DONE {
                value.Id = Int(sqlite3_last_insert_rowid(dbPointer))
                for image in value.Images {
                    if DataContext.Instance.Images.insert(value: Image(Id: 0, Area: value, Table: Table(), MenuItem: MenuItem(), Path: image.Path)).Id != 0 {
                        print("sql create \(tableName) image \(image) success")
                    }
                    else {
                        print("sql create \(tableName) image \(image) fail")
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
    func update(value: Area) -> Bool {
        var result = false
        let dbPointer = MySqlite.open()
        let query = "UPDATE \(tableName) SET name = ?, description = ? WHERE id = ?;"
        var sqlPointer : OpaquePointer? = nil
        if sqlite3_prepare_v2(dbPointer, query, -1, &sqlPointer, nil) == SQLITE_OK {
            sqlite3_bind_text(sqlPointer, 1, value.Name.cString(using: .utf8), -1, SQLITE_TRANSIENT)
            sqlite3_bind_text(sqlPointer, 2, value.Description.cString(using: .utf8), -1, SQLITE_TRANSIENT)
            sqlite3_bind_int(sqlPointer, 3, Int32(value.Id))
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
    func all() -> [Area] {
        var result = [Area]()
        let dbPointer = MySqlite.open()
        let query = "SELECT id, name, description FROM \(tableName);"
        var sqlPointer : OpaquePointer? = nil
        if sqlite3_prepare_v2(dbPointer, query, -1, &sqlPointer, nil) == SQLITE_OK {
            while sqlite3_step(sqlPointer) == SQLITE_ROW {
                let area = Area(Id: Int(sqlite3_column_int(sqlPointer, 0)),
                                Name: String(cString: sqlite3_column_text(sqlPointer, 1)!),
                                Description: String(cString: sqlite3_column_text(sqlPointer, 2)!),
                                Images:[Image]())
                area.Images = DataContext.Instance.Images.all(id: area.Id, tables: .AREA)
                result.append(area)
            }
            print("select \(tableName) success")
        }
        else {
            print("query all \(tableName) not ok")
        }
        sqlite3_finalize(sqlPointer)
        sqlite3_close(dbPointer)
        return result
    }
    func get(id: Int) -> Area {
        var result = Area()
        let dbPointer = MySqlite.open()
        let query = "SELECT id, name, description FROM \(tableName) WHERE id=?;"
        var sqlPointer : OpaquePointer? = nil
        if sqlite3_prepare_v2(dbPointer, query, -1, &sqlPointer, nil) == SQLITE_OK {
            sqlite3_bind_int(sqlPointer, 1, Int32(id))
            if sqlite3_step(sqlPointer) == SQLITE_ROW {
                result = Area(Id: Int(sqlite3_column_int(sqlPointer, 0)),
                              Name: String(cString: sqlite3_column_text(sqlPointer, 1)!),
                              Description: String(cString: sqlite3_column_text(sqlPointer, 2)!),
                              Images:[Image]())
                result.Images = DataContext.Instance.Images.all(id: result.Id, tables: .AREA)
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
