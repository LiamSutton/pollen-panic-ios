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
            "CREATE TABLE IF NOT EXISTS leaderboard(Id INTEGER PRIMARY KEY,username TEXT,score INTETGER);"
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
}
