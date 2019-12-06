//
//  SQLiteConnection.swift
//  UbUTT
//
//  Created by if26-grp1 on 06/12/2019.
//  Copyright © 2019 BourdelatPieret. All rights reserved.
//

import Foundation
import SQLite3

class SQLiteConnection {
    private var fileURL:URL
    private var db: OpaquePointer?
    private var stmt: OpaquePointer?
    private var cursorRead:Bool
    private var paramNum:Int
    
    init(){
        self.fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent("Utilisateur.sqlite")
        
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK {
            print("error opening database")
        }
        
        if sqlite3_exec(db, "CREATE TABLE IF NOT EXISTS UTILISATEUR (ID_UTILISATEUR INTEGER PRIMARY KEY, NUM_TELEPHONE TEXT NOT NULL, PASSWORD TEXT NOT NULL)", nil, nil, nil) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error creating table: \(errmsg)")
        }
        cursorRead=true
        paramNum=1
    }
    
    public func prepare(queryString:String){
        cursorRead=true
        paramNum=1
        if sqlite3_prepare(db, queryString, -1, &stmt, nil) != SQLITE_OK{
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error preparing: \(errmsg)")
            return
        }
    }
    
    public func addParamText(param:String){
        if sqlite3_bind_text(stmt, Int32(paramNum), param, -1, nil) != SQLITE_OK{
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("failure adding parameters: \(errmsg)")
            return
        }
        paramNum+=1
    }
    
    public func addParamInt(param:Int){
        if sqlite3_bind_int(stmt, Int32(paramNum), Int32(param)) != SQLITE_OK{
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("failure adding parameters: \(errmsg)")
            return
        }
        paramNum+=1
    }
    
    public func execute(){
        let res:Int32 = sqlite3_step(stmt)
        if(res == SQLITE_ROW){
            cursorRead=true
        } else if(res == SQLITE_DONE){
            cursorRead=false
        } else {
            print(sqlite3_errmsg(stmt))
        }
    }
    
    public func readText(column:Int) -> String?{
        if(cursorRead){
            if(sqlite3_column_text(stmt, Int32(column)) != nil){
                return String(cString: sqlite3_column_text(stmt, Int32(column)))
            } else {
                return nil
            }
        } else {
            return nil
        }
    }
    
    public func readInt(column:Int) -> Int?{
        if(cursorRead){
            return Int(sqlite3_column_int(stmt, Int32(column)))
        } else {
            return nil
        }
    }
    
    public func next(){
        if(sqlite3_step(stmt) == SQLITE_ROW){
            cursorRead=true
        } else{
            cursorRead=false
        }
    }
    
    public func canRead() -> Bool{
        return cursorRead
    }
    
    public func close() {
        sqlite3_finalize(stmt)
    }
}

