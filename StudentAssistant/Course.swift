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
    
    convenience init(random: Bool = false) {
        if random {
            let adjectives = ["Fluffy", "Rusty", "Shiny"]
            let nouns = ["Bear", "Spork", "Mac"]
            
            var idx = arc4random_uniform(UInt32(adjectives.count))
            let randomAdjective = adjectives[Int(idx)]
            
            idx = arc4random_uniform(UInt32(nouns.count))
            let randomNoun = nouns[Int(idx)]
            
            let randomName = "\(randomAdjective) \(randomNoun)"
            let randomDate = String(arc4random_uniform(100))
            let randomCourseNum = UUID().uuidString.components(separatedBy: "-").first!
            
            
            self.init(name: randomName,
                      courseNum: randomCourseNum,
                      date: randomDate)
        }
        else {
            self.init(name: "", courseNum: "", date: "")
        }
    }
}
