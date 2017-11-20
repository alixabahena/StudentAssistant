//
//  CourseStore.swift
//  StudentAssistant
//
//  Created by Alixa Bahena on 11/19/17.
//  Copyright © 2017 AlixaBahena. All rights reserved.
//

import Foundation

class CourseStore {
    
    var allCourses = [Course]()
    
    @discardableResult func createItem() -> Course {
        let newItem = Course(random: true)
        allCourses.append(newItem)
        return newItem
    }
    
    init() {
        for _ in 0..<5 {
            createItem()
        }
    }
 
    func removeCourse(_ item: Course) {
        if let index = allCourses.index(of: item) {
            allCourses.remove(at: index)
        }
    }
    
    func moveCourse(from fromIndex: Int, to toIndex: Int) {
        if fromIndex == toIndex {
            return
        }
        // Get reference to object being moved so you can reinsert it
        let movedCourse = allCourses[fromIndex]
        
        // Remove item from array
        allCourses.remove(at: fromIndex)
        
        // Insert item in array at new location
        allCourses.insert(movedCourse, at: toIndex)
    }
}
