//
//  Assignment.swift
//  StudentAssistant
//
//  Created by Alixa Bahena on 11/17/17.
//  Copyright © 2017 AlixaBahena. All rights reserved.
//

import UIKit

class Assignment: NSObject, NSCoding {
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: "name")
        aCoder.encode(date, forKey: "date")
        aCoder.encode(pictureKey, forKey: "pictureKey")
    }
    
    required init?(coder aDecoder: NSCoder) {
        name = aDecoder.decodeObject(forKey: "name") as! String
        date = aDecoder.decodeObject(forKey: "date") as! Date
        pictureKey = aDecoder.decodeObject(forKey: "pictureKey") as! String
        
        super.init()
    }
    
    var name: String
    var date: Date
    var pictureKey: String
    
    init(name: String, date: Date) {
        self.name = name
        self.date = date
        self.pictureKey = NSUUID().uuidString
        super.init()
    }
    
    
}
