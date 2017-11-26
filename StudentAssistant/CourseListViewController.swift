//
//  CourseListViewController.swift
//  StudentAssistant
//
//  Created by Alixa Bahena on 11/17/17.
//  Copyright © 2017 AlixaBahena. All rights reserved.
//

import UIKit

class CourseListViewController: UITableViewController{
    var courseStore: CourseStore!
    var imageStore: ImageStore!
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return courseStore.allCourses.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Create an instance of UITableViewCell, with default appearance
        //let cell = UITableViewCell(style: .value1, reuseIdentifier: "UITableViewCell")
        
        // Get a new or recycled cell
        //let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        let cell = tableView.dequeueReusableCell( withIdentifier: "ItemCell", for: indexPath) as! ItemCell
        
        // Set the text on the cell with the description of the item
        // that is at the nth index of items, where n = row this cell
        // will appear in on the tableview
        let item = courseStore.allCourses[indexPath.row]
        
        //cell.textLabel?.text = item.name
        //cell.detailTextLabel?.text = "$\(item.valueInDollars)"
        
        cell.courseNameLabel.text = item.name
        cell.courseNumLable.text = item.courseNum
       
        
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Get the height of the status bar
        //let statusBarHeight = UIApplication.shared.statusBarFrame.height
        //let insets = UIEdgeInsets(top: statusBarHeight+1, left: 0, bottom: 0, right: 0)
        //tableView.contentInset = insets
        //tableView.scrollIndicatorInsets = insets
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.rowHeight = 45
        tableView.estimatedRowHeight = 45
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView,
                            moveRowAt sourceIndexPath: IndexPath,
                            to destinationIndexPath: IndexPath) {
        // Update the model
        courseStore.moveCourse(from: sourceIndexPath.row, to: destinationIndexPath.row)
        tableView.reloadData()
        //updating the model so that the items stay in index order
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        // If the table view is asking to commit a delete command...
        if editingStyle == .delete {
            let courseIndex = indexPath.row;
            let course = courseStore.allCourses[courseIndex]
            
            //Step-a. Create an alert
            let title = "Delete \(course.name)?"
            let message = "Are you sure you want to delete this item?"
            
            let ac = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
            
            //Step-b. Add actions
            //a. cancel button
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil); ac.addAction(cancelAction)
            
            //b. delete button
            let deleteAction = UIAlertAction(title: "Delete", style: .destructive, handler: {
                (action) -> Void in
                // Remove the item from the store
                self.courseStore.removeCourse(course)
               // self.imageStore.deleteImage(forKey: course.itemKey)
                // Also remove that row from the table view with an animation
                self.tableView.deleteRows(at: [indexPath], with: .automatic)
                tableView.reloadData()
            })
            ac.addAction(deleteAction)
            
            //c. Present the alert controller
            present(ac, animated: true, completion: nil)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        navigationItem.leftBarButtonItem = editButtonItem
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "AddCourse")
        {
        let newVC:AddCourseViewController = segue.destination as! AddCourseViewController
        newVC.courseStore = courseStore
        }
        
        if (segue.identifier == "CourseView")
        {
            let newVC:CourseViewController = segue.destination as! CourseViewController
            
            // Figure out which row was just tapped
            if let row = tableView.indexPathForSelectedRow?.row {
                
                // Get the item associated with this row and pass it along
                let course = courseStore.allCourses[row]
                newVC.course = course
                newVC.courseStore = courseStore
                newVC.imageStore = imageStore
        }
        }
        
        
}
}
