//
//  AreaContext.swift
//  Midterm
//
//  Created by An Le on 4/25/17.
//  Copyright © 2017 IMIT. All rights reserved.
//

import UIKit

class AreaContext: NSObject {
    public static func insert(value: Area) {
        let dbPointer = MySqlite.open()
        var query = "INSERT INTO area (name, description) VALUES (?, ?);"
        var sqlPointer : OpaquePointer? = nil
        if sqlite3_prepare_v2(dbPointer, query, -1, &sqlPointer, nil) == SQLITE_OK {
            sqlite3_bind_text(sqlPointer, 1, value.Name.cString(using: .utf8), -1, SQLITE_TRANSIENT)
            sqlite3_bind_text(sqlPointer, 2, value.Description.cString(using: .utf8), -1, SQLITE_TRANSIENT)
            if sqlite3_step(sqlPointer) == SQLITE_DONE {
                let id = sqlite3_last_insert_rowid(sqlPointer)
                for image in value.Images {
                    sqlite3_reset(sqlPointer)
                    query = "INSERT INTO image (areaid, path) VALUES (?, ?);"
                    if sqlite3_prepare_v2(dbPointer, query, -1, &sqlPointer, nil) == SQLITE_OK {
                        sqlite3_bind_int(sqlPointer, 1, Int32(id))
                        sqlite3_bind_text(sqlPointer, 2, image.cString(using: .utf8), -1, SQLITE_TRANSIENT)
                        if sqlite3_step(sqlPointer) == SQLITE_DONE {
                            print("created area image success")
                        }
                    }
                    else {
                        print("sql create area image fail")
                    }
                }
            }
            else {
                print("create area fail")
            }
        }
        else {
            print("query create area not ok")
        }
        sqlite3_finalize(sqlPointer)
        sqlite3_close(dbPointer)
    }
    public static func update(value: Area) {
        let dbPointer = MySqlite.open()
        let query = "UPDATE area SET name = ?, description = ? WHERE id = ?;"
        var sqlPointer : OpaquePointer? = nil
        if sqlite3_prepare_v2(dbPointer, query, -1, &sqlPointer, nil) == SQLITE_OK {
            sqlite3_bind_text(sqlPointer, 1, value.Name.cString(using: .utf8), -1, SQLITE_TRANSIENT)
            sqlite3_bind_text(sqlPointer, 2, value.Description.cString(using: .utf8), -1, SQLITE_TRANSIENT)
            sqlite3_bind_int(sqlPointer, 3, Int32(value.Id))
            if sqlite3_step(sqlPointer) == SQLITE_DONE {
                print("updated area success")
            }
            else {
                print("update area fail")
            }
        }
        else {
            print("query update area not ok")
        }
        sqlite3_finalize(sqlPointer)
        sqlite3_close(dbPointer)
    }
    public static func delete(id: Int) {
        let dbPointer = MySqlite.open()
        let query = "DELETE FROM area WHERE id = ?;"
        var sqlPointer : OpaquePointer? = nil
        if sqlite3_prepare_v2(dbPointer, query, -1, &sqlPointer, nil) == SQLITE_OK {
            sqlite3_bind_int(sqlPointer, 1, Int32(id))
            if sqlite3_step(sqlPointer) == SQLITE_DONE {
                print("delete area success")
            }
            else {
                print("delete area success")
            }
        }
        else {
            print("query delete area not ok")
        }
        sqlite3_finalize(sqlPointer)
        sqlite3_close(dbPointer)
    }
    public static func all() -> [Area] {
        var result = [Area]()
        let dbPointer = MySqlite.open()
        let query = "SELECT id, name, description FROM area;"
        var sqlPointer : OpaquePointer? = nil
        if sqlite3_prepare_v2(dbPointer, query, -1, &sqlPointer, nil) == SQLITE_OK {
            while sqlite3_step(sqlPointer) == SQLITE_ROW {
                let area = Area(Id: Int(sqlite3_column_int(sqlPointer, 0)),
                                Name: String(cString: sqlite3_column_text(sqlPointer, 1)!),
                                Description: String(cString: sqlite3_column_text(sqlPointer, 2)!),
                                Images:[String]())
                let queryImage = "SELECT path FROM image WHERE areaid = ?"
                var sqlPointerImage : OpaquePointer? = nil
                if sqlite3_prepare_v2(dbPointer, queryImage, -1, &sqlPointerImage, nil) == SQLITE_OK {
                    sqlite3_bind_int(sqlPointerImage, 1, Int32(area.Id))
                    while sqlite3_step(sqlPointerImage) == SQLITE_ROW {
                        let path = String(cString: sqlite3_column_text(sqlPointerImage, 0)!)
                        area.Images.append(path)
                    }
                    result.append(area)
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
    public static func get(id: Int) -> Area {
        var result = Area()
        let dbPointer = MySqlite.open()
        let query = "SELECT id, name, description FROM area WHERE id=?;"
        var sqlPointer : OpaquePointer? = nil
        if sqlite3_prepare_v2(dbPointer, query, -1, &sqlPointer, nil) == SQLITE_OK {
            sqlite3_bind_int(sqlPointer, 1, Int32(id))
            if sqlite3_step(sqlPointer) == SQLITE_DONE {
                result = Area(Id: Int(sqlite3_column_int(sqlPointer, 0)),
                              Name: String(cString: sqlite3_column_text(sqlPointer, 1)!),
                              Description: String(cString: sqlite3_column_text(sqlPointer, 2)!),
                              Images:[String]())
                let queryImage = "SELECT path FROM image WHERE areaid = ?"
                var sqlPointerImage : OpaquePointer? = nil
                if sqlite3_prepare_v2(dbPointer, queryImage, -1, &sqlPointerImage, nil) == SQLITE_OK {
                    sqlite3_bind_int(sqlPointerImage, 1, Int32(result.Id))
                    while sqlite3_step(sqlPointerImage) == SQLITE_ROW {
                        let path = String(cString: sqlite3_column_text(sqlPointerImage, 0)!)
                        result.Images.append(path)
                    }
                    print("select one area success")
                }
                sqlite3_finalize(sqlPointerImage)
            }
        }
        else {
            print("query one area not ok")
        }
        sqlite3_finalize(sqlPointer)
        sqlite3_close(dbPointer)
        return result
    }
}
