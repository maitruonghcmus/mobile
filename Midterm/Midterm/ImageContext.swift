//
//  ImageContext.swift
//  Midterm
//
//  Created by An Le on 4/26/17.
//  Copyright © 2017 IMIT. All rights reserved.
//

import Foundation



class ImageContext {
    enum TABLES : String{
        case TABLE = "table", AREA = "area", MENUITEM = "menuitem"
    }
    let tableName = "image"
    func insert(value: Image) -> Image {
        let result = value
        let dbPointer = MySqlite.open()
        let query = "INSERT INTO \(tableName) (areaid, tableid, menuitemid, path) VALUES (?, ?, ?, ?);"
        var sqlPointer : OpaquePointer? = nil
        if sqlite3_prepare_v2(dbPointer, query, -1, &sqlPointer, nil) == SQLITE_OK {
            sqlite3_bind_int(sqlPointer, 1, Int32((value.Area?.Id)!))
            sqlite3_bind_int(sqlPointer, 2, Int32((value.Table?.Id)!))
            sqlite3_bind_int(sqlPointer, 3, Int32((value.MenuItem?.Id)!))
            sqlite3_bind_text(sqlPointer, 4, value.Path.cString(using: .utf8), -1, SQLITE_TRANSIENT)
            if sqlite3_step(sqlPointer) == SQLITE_DONE {
                let id = sqlite3_last_insert_rowid(dbPointer)
                result.Id = Int(id)
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
        return result
    }
    func update(value: Image) -> Bool {
        var result = false
        let dbPointer = MySqlite.open()
        let query = "UPDATE \(tableName) SET areaid = ?, tableid = ?, menuitemid = ?, path = ? WHERE id = ?;"
        var sqlPointer : OpaquePointer? = nil
        if sqlite3_prepare_v2(dbPointer, query, -1, &sqlPointer, nil) == SQLITE_OK {
            sqlite3_bind_int(sqlPointer, 1, Int32((value.Area?.Id)!))
            sqlite3_bind_int(sqlPointer, 2, Int32((value.Table?.Id)!))
            sqlite3_bind_int(sqlPointer, 3, Int32((value.MenuItem?.Id)!))
            sqlite3_bind_text(sqlPointer, 4, value.Path.cString(using: .utf8), -1, SQLITE_TRANSIENT)
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
    func all() -> [Image] {
        var result = [Image]()
        let dbPointer = MySqlite.open()
        let query = "SELECT id, areaid, tableid, menuitemid, path FROM \(tableName);"
        var sqlPointer : OpaquePointer? = nil
        if sqlite3_prepare_v2(dbPointer, query, -1, &sqlPointer, nil) == SQLITE_OK {
            while sqlite3_step(sqlPointer) == SQLITE_ROW {
                let image = Image(Id: Int(sqlite3_column_int(sqlPointer, 0)),
                                Area: DataContext.Instance.Areas.get(id: Int(sqlite3_column_int(sqlPointer, 1))),
                                Table: DataContext.Instance.Tables.get(id: Int(sqlite3_column_int(sqlPointer, 2))),
                                MenuItem: DataContext.Instance.MenuItems.get(id: Int(sqlite3_column_int(sqlPointer, 3))),
                                Path: String(cString: sqlite3_column_text(sqlPointer, 4)!))
                result.append(image)
            }
            print("select \(tableName) success")
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
        let query = "SELECT id, areaid, tableid, menuitemid, path FROM \(tableName) WHERE id=?;"
        var sqlPointer : OpaquePointer? = nil
        if sqlite3_prepare_v2(dbPointer, query, -1, &sqlPointer, nil) == SQLITE_OK {
            sqlite3_bind_int(sqlPointer, 1, Int32(id))
            if sqlite3_step(sqlPointer) == SQLITE_ROW {
                result = Image(Id: Int(sqlite3_column_int(sqlPointer, 0)),
                               Area: DataContext.Instance.Areas.get(id: Int(sqlite3_column_int(sqlPointer, 1))),
                               Table: DataContext.Instance.Tables.get(id: Int(sqlite3_column_int(sqlPointer, 2))),
                               MenuItem: DataContext.Instance.MenuItems.get(id: Int(sqlite3_column_int(sqlPointer, 3))),
                               Path: String(cString: sqlite3_column_text(sqlPointer, 4)!))
                print("select one \(tableName) success")
                
            }
            else {
                print("select one \(tableName) fail")
            }
        }
        else {
            print("query one \(tableName) not ok")
        }
        sqlite3_finalize(sqlPointer)
        sqlite3_close(dbPointer)
        return result
    }
    func all(id: Int,tables: TABLES) -> [Image] {
        var result = [Image]()
        let dbPointer = MySqlite.open()
        var columnName = ""
        switch tables {
        case TABLES.AREA:
            columnName = "areaid"
            break;
        case TABLES.MENUITEM:
            columnName = "menuitemid"
        default:
            columnName = "tableid"
        }
        let query = "SELECT id, areaid, tableid, menuitemid, path FROM \(tableName) WHERE \(columnName)=?;"
        var sqlPointer : OpaquePointer? = nil
        if sqlite3_prepare_v2(dbPointer, query, -1, &sqlPointer, nil) == SQLITE_OK {
            sqlite3_bind_int(sqlPointer, 1, Int32(id))
            while sqlite3_step(sqlPointer) == SQLITE_ROW {
                result.append(Image(Id: Int(sqlite3_column_int(sqlPointer, 0)),
                               Area: DataContext.Instance.Areas.get(id: Int(sqlite3_column_int(sqlPointer, 1))),
                               Table: DataContext.Instance.Tables.get(id: Int(sqlite3_column_int(sqlPointer, 2))),
                               MenuItem: DataContext.Instance.MenuItems.get(id: Int(sqlite3_column_int(sqlPointer, 3))),
                               Path: String(cString: sqlite3_column_text(sqlPointer, 4)!)))
                
            }
            print("select all \(tableName) \(columnName) success")
        }
        else {
            print("query all \(tableName) not ok")
        }
        sqlite3_finalize(sqlPointer)
        sqlite3_close(dbPointer)
        return result
    }
}
