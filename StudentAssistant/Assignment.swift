//
//  Assignment.swift
//  StudentAssistant
//
//  Created by Alixa Bahena on 11/17/17.
//  Copyright © 2017 AlixaBahena. All rights reserved.
//

import UIKit

class Assignment: NSObject {
    var name: String
    var date: NSDate
    var itemKey: String
    
    init(name: String, date: NSDate, itemKey: String) {
        self.name = name
        self.date = date
        self.itemKey = itemKey
        super.init()
    }
}
