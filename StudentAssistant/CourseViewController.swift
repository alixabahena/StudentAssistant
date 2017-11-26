//
//  CourseViewController.swift
//  StudentAssistant
//
//  Created by Alixa Bahena on 11/17/17.
//  Copyright © 2017 AlixaBahena. All rights reserved.
//

import UIKit


class CourseViewController: UITableViewController{
    
    
    @IBOutlet var editBarButton: UIBarButtonItem!
    var courseStore: CourseStore!
    var imageStore: ImageStore!
    var course: Course!{
        didSet{
            navigationItem.title = course.courseNum
        }
    }
    
    var senderID: Int = 0
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return course.assignmentArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Create an instance of UITableViewCell, with default appearance
        //let cell = UITableViewCell(style: .value1, reuseIdentifier: "UITableViewCell")
        
        // Get a new or recycled cell
        //let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        let cell = tableView.dequeueReusableCell( withIdentifier: "CourseCell", for: indexPath) as! CourseCell
        
        // Set the text on the cell with the description of the item
        // that is at the nth index of items, where n = row this cell
        // will appear in on the tableview
        let item = course.assignmentArray[indexPath.row]
        
        //cell.textLabel?.text = item.name
        //cell.detailTextLabel?.text = "$\(item.valueInDollars)"
        cell.assignmentLabel.text = item.name
        
        let formatter = DateFormatter()
        // initially set the format based on your datepicker date
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let localDate = formatter.string(from: item.date)
        cell.assignmentDueDateLabel.text = localDate
      
        
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
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        navigationItem.rightBarButtonItem = editButtonItem
        
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        // If the table view is asking to commit a delete command...
        if editingStyle == .delete {
            let assignmentIndex = indexPath.row;
            let assignment = course.assignmentArray[assignmentIndex]
            
            //Step-a. Create an alert
            let title = "Delete \(assignment.name)?"
            let message = "Are you sure you want to delete this item?"
            
            let ac = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
            
            //Step-b. Add actions
            //a. cancel button
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil); ac.addAction(cancelAction)
            
            //b. delete button
            let deleteAction = UIAlertAction(title: "Delete", style: .destructive, handler: {
                (action) -> Void in
                // Remove the item from the store
                self.course.assignmentArray.remove(at: assignmentIndex)
                self.imageStore.deleteImage(forKey: self.course.assignmentArray[assignmentIndex].pictureKey)
                // Also remove that row from the table view with an animation
                self.tableView.deleteRows(at: [indexPath], with: .automatic)
                tableView.reloadData()
            })
            ac.addAction(deleteAction)
            
            //c. Present the alert controller
            present(ac, animated: true, completion: nil)
        }
    }
    
    override func tableView(_ tableView: UITableView,
                            moveRowAt sourceIndexPath: IndexPath,
                            to destinationIndexPath: IndexPath) {
        // Update the model
        tableView.reloadData()
        //updating the model so that the items stay in index order
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "addAssignmentSegue") {
            
            let newVC:AddAssignmentViewController = segue.destination as! AddAssignmentViewController
            
                // Get the item associated with this row and pass it along
            senderID = 1
                newVC.course = course
                newVC.courseStore = courseStore
                newVC.imageStore = imageStore
            if let row = tableView.indexPathForSelectedRow?.row {
               newVC.localRow = row
            }
    }
        
        if (segue.identifier == "editAssignment") {
            
            let newVC:AddAssignmentViewController = segue.destination as! AddAssignmentViewController
            
            // Get the item associated with this row and pass it along
            senderID = 2
            newVC.course = course
            newVC.courseStore = courseStore
            newVC.imageStore = imageStore
            newVC.senderID = senderID
            if let row = tableView.indexPathForSelectedRow?.row {
                newVC.localRow = row
            }
        }
    
    
}
}
