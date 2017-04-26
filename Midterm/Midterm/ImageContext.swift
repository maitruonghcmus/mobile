//
//  ImageContext.swift
//  Midterm
//
//  Created by An Le on 4/26/17.
//  Copyright © 2017 IMIT. All rights reserved.
//

import Foundation

class ImageContext {
    func insert(value: Image) -> Image {
        let result = value
        let dbPointer = MySqlite.open()
        let query = "INSERT INTO image (areaid, tableid, menuitemid, path) VALUES (?, ?, ?, ?);"
        var sqlPointer : OpaquePointer? = nil
        if sqlite3_prepare_v2(dbPointer, query, -1, &sqlPointer, nil) == SQLITE_OK {
            sqlite3_bind_int(sqlPointer, 1, Int32((value.Area?.Id)!))
            sqlite3_bind_int(sqlPointer, 2, Int32((value.Table?.Id)!))
            sqlite3_bind_int(sqlPointer, 3, Int32((value.MenuItem?.Id)!))
            sqlite3_bind_text(sqlPointer, 4, value.Path.cString(using: .utf8), -1, SQLITE_TRANSIENT)
            if sqlite3_step(sqlPointer) == SQLITE_DONE {
                let id = sqlite3_last_insert_rowid(sqlPointer)
                result.Id = Int(id)
                print("created image success")
                
            }
            else {
                print("create image fail")
            }
        }
        else {
            print("query create image not ok")
        }
        sqlite3_finalize(sqlPointer)
        sqlite3_close(dbPointer)
        return result
    }
    func update(value: Image) {
        let dbPointer = MySqlite.open()
        let query = "UPDATE area SET areaid = ?, tableid = ?, menuitemid = ?, path = ? WHERE id = ?;"
        var sqlPointer : OpaquePointer? = nil
        if sqlite3_prepare_v2(dbPointer, query, -1, &sqlPointer, nil) == SQLITE_OK {
            sqlite3_bind_int(sqlPointer, 1, Int32((value.Area?.Id)!))
            sqlite3_bind_int(sqlPointer, 2, Int32((value.Table?.Id)!))
            sqlite3_bind_int(sqlPointer, 3, Int32((value.MenuItem?.Id)!))
            sqlite3_bind_text(sqlPointer, 4, value.Path.cString(using: .utf8), -1, SQLITE_TRANSIENT)
            sqlite3_bind_int(sqlPointer, 5, Int32(value.Id))
            if sqlite3_step(sqlPointer) == SQLITE_DONE {
                print("updated image success")
            }
            else {
                print("update image fail")
            }
        }
        else {
            print("query update image not ok")
        }
        sqlite3_finalize(sqlPointer)
        sqlite3_close(dbPointer)
    }
    func delete(id: Int) {
        let dbPointer = MySqlite.open()
        let query = "DELETE FROM image WHERE id = ?;"
        var sqlPointer : OpaquePointer? = nil
        if sqlite3_prepare_v2(dbPointer, query, -1, &sqlPointer, nil) == SQLITE_OK {
            sqlite3_bind_int(sqlPointer, 1, Int32(id))
            if sqlite3_step(sqlPointer) == SQLITE_DONE {
                print("delete image success")
            }
            else {
                print("delete image success")
            }
        }
        else {
            print("query delete image not ok")
        }
        sqlite3_finalize(sqlPointer)
        sqlite3_close(dbPointer)
    }
    func all() -> [Image] {
        var result = [Image]()
        let dbPointer = MySqlite.open()
        let query = "SELECT id, areaid, tableid, menuitemid, path FROM area;"
        var sqlPointer : OpaquePointer? = nil
        if sqlite3_prepare_v2(dbPointer, query, -1, &sqlPointer, nil) == SQLITE_OK {
            while sqlite3_step(sqlPointer) == SQLITE_ROW {
                let image = Image(Id: Int(sqlite3_column_int(sqlPointer, 0)),
                                Area: DataContext.Instance.Areas.get(id: Int(sqlite3_column_int(sqlPointer, 1))),
                                Table: DataContext.Instance.Tables.get(id: Int(sqlite3_column_int(sqlPointer, 2))),
                                MenuItem: DataContext.Instance.MenuItems.get(id: Int(sqlite3_column_int(sqlPointer, 3))),
                                Path: String(cString: sqlite3_column_text(sqlPointer, 4)!))
                print("select area success")
                result.append(image)
            }
        }
        else {
            print("query all area not ok")
        }
        sqlite3_finalize(sqlPointer)
        sqlite3_close(dbPointer)
        return result
    }
    func get(id: Int) -> Image {
        var result = Image()
        let dbPointer = MySqlite.open()
        let query = "SELECT id, areaid, tableid, menuitemid, path FROM area WHERE id=?;"
        var sqlPointer : OpaquePointer? = nil
        if sqlite3_prepare_v2(dbPointer, query, -1, &sqlPointer, nil) == SQLITE_OK {
            sqlite3_bind_int(sqlPointer, 1, Int32(id))
            if sqlite3_step(sqlPointer) == SQLITE_DONE {
                result = Image(Id: Int(sqlite3_column_int(sqlPointer, 0)),
                               Area: DataContext.Instance.Areas.get(id: Int(sqlite3_column_int(sqlPointer, 1))),
                               Table: DataContext.Instance.Tables.get(id: Int(sqlite3_column_int(sqlPointer, 2))),
                               MenuItem: DataContext.Instance.MenuItems.get(id: Int(sqlite3_column_int(sqlPointer, 3))),
                               Path: String(cString: sqlite3_column_text(sqlPointer, 4)!))
                print("select one area success")
                
            }
            else {
                print("select one image fail")
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
