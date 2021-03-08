//
//  DatabaseHelper.swift
//  PollenPanic
//
//  Created by Liam Sutton on 05/03/2021.
//

import Foundation
import SQLite3

// This class is used to facilitate interaction with an sqlite database
class DatabaseHelper {
    
    var database:OpaquePointer? // Pointer to db object
    let databasePath:String = Constants.DATABASE_FILE_NAME // path to the database file
    
    // Constructor: opens a connection to the database and creates necessary tables if they dont exist
    init() {
        database = openDatabase()
        createTable()
    }
    
    // Opens a connection to the database
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
    
    // if required, creates the database according to my schema
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
    
    // Inserts a row into the database representing a leaderboard entry
    func insert(username: String, score: Int) -> Bool{
        var succesfullyInserted:Bool? = nil
        let insertStatementString:String = "INSERT INTO leaderboard (username, score) VALUES (?, ?)"
        var insertStatement:OpaquePointer? = nil
        if sqlite3_prepare_v2(database, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
            sqlite3_bind_text(insertStatement, 1, (username as NSString).utf8String, -1, nil)
            sqlite3_bind_int(insertStatement, 2, Int32(score))
            
            if sqlite3_step(insertStatement) == SQLITE_DONE {
                print("Succesfully inserted row")
                succesfullyInserted = true
            }
            else {
                print("Couldnt insert row")
                succesfullyInserted = false
            }
        }
        else {
            print("Couldnt prepare insert statement")
        }
        sqlite3_finalize(insertStatement)
        return succesfullyInserted!
    }
    
    // retrieves the top 10 entries from the leaderboard table
    func getLeaderboardData() -> [LeaderBoardEntry] {
        let queryStatementString:String = "SELECT * FROM leaderboard ORDER BY score DESC LIMIT 0,10"
        var queryStatement:OpaquePointer? = nil
        var entries:[LeaderBoardEntry] = []
        
        if sqlite3_prepare_v2(database, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            while sqlite3_step(queryStatement) == SQLITE_ROW {
                let id:Int32 = sqlite3_column_int(queryStatement, 0)
                let username:String = String(describing: String(cString: sqlite3_column_text(queryStatement, 1)))
                let score:Int32 = sqlite3_column_int(queryStatement, 2)
                
                entries.append(LeaderBoardEntry(id: Int(id), username: username, score: Int(score)))
                print("ROW DATA: \(id) | \(username) | \(score)")
            }
        }
        else {
            print("SELECT statement couldnt be prepared")
        }
        sqlite3_finalize(queryStatement)
        return entries
    }
}
