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
    var assignments = [Assignment]()
    
    @IBAction func cancelButtonClicked(_ sender: UIButton) {
        courseNumTextField.text = ""
        courseNameTextField.text = ""
        courseDateTextField.text = ""
    }
    
    @IBAction func addButtonClicked(_ sender: UIButton) {
        let courseNum: String = courseNumTextField.text!
        let courseName: String = courseNameTextField.text!
        let courseDate: String = courseDateTextField.text!
       
    
        let newCourse = Course(name: courseName, courseNum: courseNum, date: courseDate, assignmentArray: assignments)
        courseStore.allCourses.append(newCourse)
        courseNumTextField.text = ""
        courseNameTextField.text = ""
        courseDateTextField.text = ""
        
        self.navigationController?.popViewController(animated: true)
        
    }
    
    @IBAction func dateFieldEditing(_ sender: UITextField) {
       
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
}

