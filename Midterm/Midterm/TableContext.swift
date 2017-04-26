//
//  TableContext.swift
//  Midterm
//
//  Created by An Le on 4/25/17.
//  Copyright © 2017 IMIT. All rights reserved.
//

import UIKit

class TableContext: NSObject {
    func insert(value: Table) {
        let dbPointer = MySqlite.open()
        var query = "INSERT INTO table (description, areaid, tablestatus) VALUES (?, ?, ?);"
        var sqlPointer : OpaquePointer? = nil
        if sqlite3_prepare_v2(dbPointer, query, -1, &sqlPointer, nil) == SQLITE_OK {
            sqlite3_bind_text(sqlPointer, 1, value.Description.cString(using: .utf8), -1, SQLITE_TRANSIENT)
            sqlite3_bind_int(sqlPointer, 2, Int32((value.Area?.Id)!))
            sqlite3_bind_int(sqlPointer, 3, Int32(value.TableStatus))
            if sqlite3_step(sqlPointer) == SQLITE_DONE {
                let id = sqlite3_last_insert_rowid(sqlPointer)
                for image in value.Images {
                    sqlite3_reset(sqlPointer)
                    query = "INSERT INTO image (tableid, path) VALUES (?, ?);"
                    if sqlite3_prepare_v2(dbPointer, query, -1, &sqlPointer, nil) == SQLITE_OK {
                        sqlite3_bind_int(sqlPointer, 1, Int32(id))
                        sqlite3_bind_text(sqlPointer, 2, image.cString(using: .utf8), -1, SQLITE_TRANSIENT)
                        if sqlite3_step(sqlPointer) == SQLITE_DONE {
                            print("created table image success")
                        }
                    }
                    else {
                        print("sql create table image fail")
                    }
                }
            }
            else {
                print("create table fail")
            }
        }
        else {
            print("query create table not ok")
        }
        sqlite3_finalize(sqlPointer)
        sqlite3_close(dbPointer)
    }
    func update(value: Table) {
        let dbPointer = MySqlite.open()
        let query = "UPDATE table SET description = ?, areaid = ?, tablestatus = ? WHERE id = ?;"
        var sqlPointer : OpaquePointer? = nil
        if sqlite3_prepare_v2(dbPointer, query, -1, &sqlPointer, nil) == SQLITE_OK {
            sqlite3_bind_text(sqlPointer, 1, value.Description.cString(using: .utf8), -1, SQLITE_TRANSIENT)
            sqlite3_bind_int(sqlPointer, 2, Int32(value.TableStatus))
            sqlite3_bind_int(sqlPointer, 3, Int32((value.Area?.Id)!))
            sqlite3_bind_int(sqlPointer, 4, Int32(value.Id))
            if sqlite3_step(sqlPointer) == SQLITE_DONE {
                print("updated table success")
            }
            else {
                print("update table fail")
            }
        }
        else {
            print("query update table not ok")
        }
        sqlite3_finalize(sqlPointer)
        sqlite3_close(dbPointer)
    }
    func delete(id: Int) {
        let dbPointer = MySqlite.open()
        let query = "DELETE FROM table WHERE id = ?;"
        var sqlPointer : OpaquePointer? = nil
        if sqlite3_prepare_v2(dbPointer, query, -1, &sqlPointer, nil) == SQLITE_OK {
            sqlite3_bind_int(sqlPointer, 1, Int32(id))
            if sqlite3_step(sqlPointer) == SQLITE_DONE {
                print("delete table success")
            }
            else {
                print("delete table success")
            }
        }
        else {
            print("query delete table not ok")
        }
        sqlite3_finalize(sqlPointer)
        sqlite3_close(dbPointer)
    }
    func all() -> [Table] {
        var result = [Table]()
        let dbPointer = MySqlite.open()
        let query = "SELECT id, description, areaid, tablestatus FROM table;"
        var sqlPointer : OpaquePointer? = nil
        if sqlite3_prepare_v2(dbPointer, query, -1, &sqlPointer, nil) == SQLITE_OK {
            while sqlite3_step(sqlPointer) == SQLITE_ROW {
                let value = Table(Id: Int(sqlite3_column_int(sqlPointer, 0)),
                                  Description: String(cString: sqlite3_column_text(sqlPointer, 1)!),
                                  Images: [String](),
                                  Area: Area(),
                                  TableStatus: Int(sqlite3_column_int(sqlPointer, 3)))
                value.Area = DataContext.Instance.Areas.get(id: Int(sqlite3_column_int(sqlPointer, 2)))
                let queryImage = "SELECT path FROM image WHERE areaid = ?"
                var sqlPointerImage : OpaquePointer? = nil
                if sqlite3_prepare_v2(dbPointer, queryImage, -1, &sqlPointerImage, nil) == SQLITE_OK {
                    sqlite3_bind_int(sqlPointerImage, 1, Int32(value.Id))
                    while sqlite3_step(sqlPointerImage) == SQLITE_ROW {
                        let path = String(cString: sqlite3_column_text(sqlPointerImage, 0)!)
                        value.Images.append(path)
                    }
                    result.append(value)
                    print("select area success")
                }
                sqlite3_finalize(sqlPointerImage)
            }
        }
        else {
            print("query all area not ok")
        }
        sqlite3_finalize(sqlPointer)
        sqlite3_close(dbPointer)
        return result
    }
    func get(id: Int) -> Table {
        var result = Table()
        let dbPointer = MySqlite.open()
        let query = "SELECT id, description, areaid, tablestatus FROM table WHERE id=?;"
        var sqlPointer : OpaquePointer? = nil
        if sqlite3_prepare_v2(dbPointer, query, -1, &sqlPointer, nil) == SQLITE_OK {
            sqlite3_bind_int(sqlPointer, 1, Int32(id))
            if sqlite3_step(sqlPointer) == SQLITE_DONE {
                result = Table(Id: Int(sqlite3_column_int(sqlPointer, 0)),
                               Description: String(cString: sqlite3_column_text(sqlPointer, 1)!),
                               Images: [String](),
                               Area: Area(),
                               TableStatus: Int(sqlite3_column_int(sqlPointer, 3)))
                result.Area = DataContext.Instance.Areas.get(id: Int(sqlite3_column_int(sqlPointer, 2)))
                let queryImage = "SELECT path FROM image WHERE areaid = ?"
                var sqlPointerImage : OpaquePointer? = nil
                if sqlite3_prepare_v2(dbPointer, queryImage, -1, &sqlPointerImage, nil) == SQLITE_OK {
                    sqlite3_bind_int(sqlPointerImage, 1, Int32(result.Id))
                    while sqlite3_step(sqlPointerImage) == SQLITE_ROW {
                        let path = String(cString: sqlite3_column_text(sqlPointerImage, 0)!)
                        result.Images.append(path)
                    }
                    print("select one table success")
                }
                sqlite3_finalize(sqlPointerImage)
            }
        }
        else {
            print("query one table not ok")
        }
        sqlite3_finalize(sqlPointer)
        sqlite3_close(dbPointer)
        return result
    }
}
