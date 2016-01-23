//
//  SQLiteManager.swift
//  SQLiteWithSwift
//
//  Created by joyann on 16/1/23.
//  Copyright © 2016年 Joyann. All rights reserved.
//

import UIKit

class SQLiteManager: NSObject {
    
    private static let sharedInstance: SQLiteManager = SQLiteManager()
    
    class func sharedManager() -> SQLiteManager {
        return sharedInstance
    }
    
    func executeSQL(statement: String) {
        
    }
    
}
