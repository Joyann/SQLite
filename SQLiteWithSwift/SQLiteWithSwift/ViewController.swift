//
//  ViewController.swift
//  SQLiteWithSwift
//
//  Created by joyann on 16/1/23.
//  Copyright © 2016年 Joyann. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    lazy var persons: [Person] = {
       let tempPersons = [Person]()
        return tempPersons
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SQLiteManager.sharedManager().openDb("person.db")
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
//        loadData()
        modifyData()
//        SQLiteManager.sharedManager().deleteTable()
        SQLiteManager.sharedManager().querySQL()
        
        
    }
    
    private func modifyData() {
        let modifySQL = "UPDATE t_person SET name='Blake' WHERE age=8"
        if SQLiteManager.sharedManager().executeSQL(modifySQL) {
            print("修改成功!")
        }
    }

    private func loadData() {
        for i in 0..<10 {
            let dic = ["name": "joyann", "age": String(i)]
            let person = Person(infoDic: dic)
            person.insertSQL()
            persons.append(person)
        }
    }

}

