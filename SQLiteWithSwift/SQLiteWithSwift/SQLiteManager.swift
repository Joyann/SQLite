//
//  SQLiteManager.swift
//  SQLiteWithSwift
//
//  Created by joyann on 16/1/23.
//  Copyright © 2016年 Joyann. All rights reserved.
//

import UIKit

class SQLiteManager: NSObject {
    
    let handler: COpaquePointer = nil
    
    private static let sharedInstance: SQLiteManager = SQLiteManager()
    
    class func sharedManager() -> SQLiteManager {
        return sharedInstance
    }
    
    func executeSQL(statement: String) -> Bool {
        let sql = statement.cStringUsingEncoding(NSUTF8StringEncoding)!
        return sqlite3_exec(handler, sql, nil, nil, nil) == SQLITE_OK
    }
    
}
