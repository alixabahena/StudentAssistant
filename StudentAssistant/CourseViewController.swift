//
//  CourseViewController.swift
//  StudentAssistant
//
//  Created by Alixa Bahena on 11/17/17.
//  Copyright © 2017 AlixaBahena. All rights reserved.
//

import UIKit


class CourseViewController: UITableViewController{
    
    var courseStore: CourseStore!
    var course: Course!{
        didSet{
            navigationItem.title = course.name
        }
    }
}