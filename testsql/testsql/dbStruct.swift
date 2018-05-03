//
//  dbClass.swift
//  testsql
//
//  Created by Tyler Arnold on 5/3/18.
//  Copyright © 2018 Tyler Arnold. All rights reserved.
//

import Foundation
import SQLite3

struct DataBase {
    var db: OpaquePointer?
    
    init() {
        db = openDatabase()
    }
    
    
}
