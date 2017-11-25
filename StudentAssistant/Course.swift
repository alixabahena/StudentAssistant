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
    var courseNum: String
    var date: String
    var assignmentArray = [Assignment]()
    
    init(name: String, courseNum: String, date: String, assignmentArray: [Assignment]) {
        self.name = name
        self.courseNum = courseNum
        self.date = date
        self.assignmentArray = assignmentArray
        super.init()
    }
}
