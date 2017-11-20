//
//  AddCourseViewController.swift
//  StudentAssistant
//
//  Created by Alixa Bahena on 11/17/17.
//  Copyright © 2017 AlixaBahena. All rights reserved.
//

import UIKit

class AddCourseViewController: UIViewController, UITextFieldDelegate, UINavigationControllerDelegate{
    
    @IBOutlet var courseNumTextField: UITextField!
    @IBOutlet var courseNameTextField: UITextField!
    @IBOutlet var courseDateTextField: UITextField!
    @IBOutlet var addButton: UIButton!
    @IBOutlet var cancelButton: UIButton!
    var courseStore: CourseStore!
    var course: Course!
    
    @IBAction func cancelButtonClicked(_ sender: UIButton) {
        courseNumTextField.text = ""
        courseNameTextField.text = ""
        courseDateTextField.text = ""
    }
    
    @IBAction func addButtonClicked(_ sender: UIButton) {
        let courseNum: String = courseNumTextField.text!
        let courseName: String = courseNameTextField.text!
        let courseDate: String = courseDateTextField.text!
        
       //let newCourse = Course(name: courseName, courseNum: courseNum, date: courseDate)
       //courseStore.allCourses.append(newCourse)
        
        course.name = courseName
        course.courseNum = courseNum
        course.date = courseDate
        
        courseNumTextField.text = ""
        courseNameTextField.text = ""
        courseDateTextField.text = ""
        
    }
    
    @IBAction func dateFieldEditing(_ sender: UITextField) {
       
    }
    
    
    
}

