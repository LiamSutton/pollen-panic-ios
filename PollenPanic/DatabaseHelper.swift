//
//  DatabaseHelper.swift
//  PollenPanic
//
//  Created by Liam Sutton on 05/03/2021.
//

import Foundation
import SQLite3

class DatabaseHelper {
    
    var database:OpaquePointer?
    let databasePath:String = "myDB.sqlite"
    
    init() {
        database = openDatabase()
        createTable()
    }
    
    func openDatabase() -> OpaquePointer? {
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent(databasePath)
        var db:OpaquePointer? = nil
        
        if (sqlite3_open(fileURL.path, &db) != SQLITE_OK) {
            print("Error Opening Database")
            return nil
        }
        else {
            print("Successfully opened connection to database at \(databasePath)")
            return db
        }
    }
    
    func createTable() {
        let createTableString:String =
            "CREATE TABLE IF NOT EXISTS leaderboard(Id INTEGER PRIMARY KEY AUTOINCREMENT,username TEXT,score INTETGER);"
        var createTableStatement: OpaquePointer? = nil
        if (sqlite3_prepare_v2(database, createTableString, -1, &createTableStatement, nil) == SQLITE_OK) {
            if (sqlite3_step(createTableStatement)) == SQLITE_DONE {
                print("Leaderboard table created")
            } else {
                print("Coudlnt create table")
            }
        } else {
            print("Create table statement couldnt be prepared")
        }
        sqlite3_finalize(createTableStatement)
    }
    
    func insert(username: String, score: Int) {
        let insertStatementString:String = "INSERT INTO leaderboard (username, score) VALUES (?, ?)"
        var insertStatement:OpaquePointer? = nil
        if sqlite3_prepare_v2(database, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
            sqlite3_bind_text(insertStatement, 1, (username as NSString).utf8String, -1, nil)
            sqlite3_bind_int(insertStatement, 2, Int32(score))
            
            if sqlite3_step(insertStatement) == SQLITE_DONE {
                print("Succesfully inserted row")
            }
            else {
                print("Couldnt insert row")
            }
        }
        else {
            print("Couldnt prepare insert statement")
        }
        sqlite3_finalize(insertStatement)
    }
}
