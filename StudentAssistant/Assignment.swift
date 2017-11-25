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
    var pictureKey: String
    
    init(name: String, date: NSDate) {
        self.name = name
        self.date = date
        self.pictureKey = NSUUID().uuidString
        super.init()
    }
}
