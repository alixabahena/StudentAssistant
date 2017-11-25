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
    
   init(name: String, courseNum: String, date: String) {
        self.name = name
        self.courseNum = courseNum
        self.date = date
        super.init()
    }

    //creates an array of assignments to store in each instance of course
    var assignmentArray = [Assignment]()
    
}
