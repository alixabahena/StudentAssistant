//
//  Course.swift
//  StudentAssistant
//
//  Created by Alixa Bahena on 11/17/17.
//  Copyright © 2017 AlixaBahena. All rights reserved.
//

import UIKit

class Course: NSObject {
    var name: String
    var courseNum: Int
    var date: NSDate
    
   init(name: String, courseNum: Int, date: NSDate) {
        self.name = name
        self.courseNum = courseNum
        self.date = date
        super.init()
    }
}
