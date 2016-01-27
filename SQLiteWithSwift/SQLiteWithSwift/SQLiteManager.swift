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
        let deleteTableSQL = "DROP TABLE IF EXISTS t_person;"
        if executeSQL(deleteTableSQL) {
            print("删除表成功!")
        }
    }
    
    // 查询数据
    func querySQL() -> [[String: AnyObject]]? {
        
        let query = "SELECT name, age FROM t_person"
        var pStmt: COpaquePointer = nil
        if sqlite3_prepare_v2(pDb, query, -1, &pStmt, nil) != SQLITE_OK {
            print("查询数据失败!")
            return nil
        }
        
        var dicts = [[String: AnyObject]]()
        
        while sqlite3_step(pStmt) == SQLITE_ROW { // 判断是否有下一行
            guard let dict = getDataWithStmt(pStmt) else {
                print("获取数据失败!")
                break
            }
            dicts.append(dict)
        }
        
        print(dicts)
        
        return dicts
    }
    
    private func getDataWithStmt(pStmt: COpaquePointer) -> [String: AnyObject]? {
        let fieldCount = sqlite3_column_count(pStmt) // 根据查询语句，当前为2个字段(name, age)

        var dict = [String: AnyObject]()
        
        for i in 0..<fieldCount {
            // 获取字段名
            let cFieldName = sqlite3_column_name(pStmt, i)
            guard let fieldName = String(CString: cFieldName, encoding: NSUTF8StringEncoding) else {
                print("获取字段名失败!")
                return nil
            }

            // 获取字段名对应的value
            let cFieldValue = sqlite3_column_text(pStmt, i)
            guard let fieldValue = String(CString: UnsafePointer(cFieldValue), encoding: NSUTF8StringEncoding) else {
                print("获取字段对应的值失败!")
                return nil
            }

            dict[fieldName] = fieldValue
        }

        return dict
    }

    // 执行SQL语句
    func executeSQL(statement: String) -> Bool {
        let sql = statement.cStringUsingEncoding(NSUTF8StringEncoding)!
        return sqlite3_exec(pDb, sql, nil, nil, nil) == SQLITE_OK
    }
    
}
