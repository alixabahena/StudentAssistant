//
//  Course.swift
//  StudentAssistant
//
//  Created by Alixa Bahena on 11/17/17.
//  Copyright © 2017 AlixaBahena. All rights reserved.
//

import UIKit

class Course: NSObject, NSCoding{
    
    required init?(coder aDecoder: NSCoder) {
        name = aDecoder.decodeObject(forKey: "name") as! String
        courseNum = aDecoder.decodeObject(forKey: "courseNum") as! String
        date = aDecoder.decodeObject(forKey: "date") as! String
        assignmentArray = aDecoder.decodeObject(forKey: "assignmentArray") as! [Assignment]

        super.init()
    }
    
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
    
    func encode(with aCoder: NSCoder){
        aCoder.encode(name, forKey: "name")
        aCoder.encode(courseNum, forKey: "courseNum")
        aCoder.encode(date, forKey: "date")
        aCoder.encode(assignmentArray, forKey: "assignmentArray")
    }
}
