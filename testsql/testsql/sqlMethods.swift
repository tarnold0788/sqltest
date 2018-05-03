//
//  sqlMethods.swift
//  testsql
//
//  Created by Tyler Arnold on 5/3/18.
//  Copyright © 2018 Tyler Arnold. All rights reserved.
//

import Foundation
import SQLite3

func openDatabase() -> OpaquePointer? {
    var db: OpaquePointer?
    let fileUrl = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent("ddcharacter.sqlite")
    if sqlite3_open(fileUrl.path, &db) == SQLITE_OK {
        return db
    }
    
    print("Failed to open Database")
    return nil
}

func createTable(db: OpaquePointer) {
    var createTableStatement: OpaquePointer?
    
    let tableString = "CREATE TABLE IF NOT EXISTS hero (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, level INTEGER, hp INTEGER)"
    
    if sqlite3_prepare(db, tableString, -1, &createTableStatement, nil) == SQLITE_OK {
        
        if sqlite3_step(createTableStatement) == SQLITE_DONE {
            print("Character table created.")
        } else {
            print("creating table failed!")
        }
    } else {
        print("Create TABLE statement failed to prepare!")
    }
    
    sqlite3_finalize(createTableStatement)
}

func insertCharacter(db: OpaquePointer, name: String, lvl: Int) {
    var insertStatement: OpaquePointer?
    let insertString = "INSERT INTO hero (name, level, hp) VALUES (?,?,8)"
    
    if sqlite3_prepare(db, insertString, -1, &insertStatement, nil) == SQLITE_OK {
        sqlite3_bind_text(insertStatement, 1, name, -1, nil)
        sqlite3_bind_int(insertStatement, 2, Int32(lvl))
        
        if sqlite3_step(insertStatement) == SQLITE_DONE {
            print("Succesfully inserted row.")
        } else {
            print("Could not insert row.")
        }
    } else {
        print("INSERT statement could not be prepared.")
    }
    
    sqlite3_finalize(insertStatement)
}
