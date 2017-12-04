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
    let courseArchiveURL: URL = {
        let documentsDirectories = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = documentsDirectories.first!
        
        return documentDirectory.appendingPathComponent("courses.archive")
        
    }()

    init(){
        if let archivedItems =
            NSKeyedUnarchiver.unarchiveObject(withFile: courseArchiveURL.path) as? [Course] {
            allCourses = archivedItems
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
    
    func saveChanges() -> Bool {
        print("Saving items to: \(courseArchiveURL.path)")
        return NSKeyedArchiver.archiveRootObject(allCourses, toFile: courseArchiveURL.path)
    }

}
