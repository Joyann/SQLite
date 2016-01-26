//
//  Person.swift
//  SQLiteWithSwift
//
//  Created by joyann on 16/1/26.
//  Copyright © 2016年 Joyann. All rights reserved.
//

import UIKit

class Person: NSObject {
    
    var name: String?
    var age = 0
    
    init (infoDic: [String: AnyObject]) {
        super.init()
        
        setValuesForKeysWithDictionary(infoDic)
    }
    
    func insertSQL() {
        let insertSQL = "INSERT INTO t_person (name, age) VALUES ('\(name ?? "")', \(age))"

        print(insertSQL)
        if SQLiteManager.sharedManager().executeSQL(insertSQL) {
            print("插入成功!")
        }
    }
}
