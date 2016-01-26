//
//  SQLiteManager.swift
//  SQLiteWithSwift
//
//  Created by joyann on 16/1/23.
//  Copyright © 2016年 Joyann. All rights reserved.
//

import UIKit

class SQLiteManager: NSObject {
    
    var pDb: COpaquePointer = nil
    
    private static let sharedInstance: SQLiteManager = SQLiteManager()
    
    class func sharedManager() -> SQLiteManager {
        return sharedInstance
    }
    
    // 创建数据库
    func openDb(dbName: String) {
        let document = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true).first
        guard let documentPath = document else {
            print("打开数据库失败!")
            return
        }
        let path = (documentPath as NSString).stringByAppendingPathComponent(dbName)
        
        // 创建数据库
        if sqlite3_open(path, &pDb) != SQLITE_OK {
            print("打开数据库失败!")
            return
        }
        
        createTable()
    }
    
    // 创建表
    private func createTable() {
        let createTableSQL = "CREATE TABLE IF NOT EXISTS t_person ( \n" +
            "id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, \n" +
            "name TEXT, \n" +
            "age INTEGER\n" +
        ");"
        if executeSQL(createTableSQL) {
            print("创建表成功!")
        } else {
            print("创建表失败!")
        }
    }
    
    // 删除表
    func deleteTable() {
        let deleteTableSQL = "DROP TABLE t_person IF EXISTS"
        if executeSQL(deleteTableSQL) {
            print("删除表成功!")
        }
    }
    
    // 执行SQL语句
    func executeSQL(statement: String) -> Bool {
        let sql = statement.cStringUsingEncoding(NSUTF8StringEncoding)!
        return sqlite3_exec(pDb, sql, nil, nil, nil) == SQLITE_OK
    }
    
}
