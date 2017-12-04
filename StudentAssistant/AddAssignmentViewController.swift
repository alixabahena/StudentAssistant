//
//  AddAssignmentViewController.swift
//  StudentAssistant
//
//  Created by Alixa Bahena on 11/17/17.
//  Copyright © 2017 AlixaBahena. All rights reserved.
//

import UIKit
import UserNotifications

class AddAssignmentViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    @IBOutlet var assignmentTextField: UITextField!
    @IBOutlet var dueDateTextField: UITextField!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var addButton: UIButton!
    @IBOutlet var cancelButton: UIButton!
    
    var imageStore: ImageStore!
    var datePicker : UIDatePicker!
    var course: Course!
    var courseStore: CourseStore!
    var localDate: Date!
    var localRow: Int = 0
    var senderID: Int = 0
    
    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter
        
    }()
    
    
    @IBAction func cancelButtonPressed(_ sender: UIButton) {
        assignmentTextField.text = ""
        dueDateTextField.text = ""
        imageView.image = nil
    }
    
    @IBAction func addButtonPressed(_ sender: UIButton) {
        
        //pull information the user entered and make it locally available
        let assignmentName: String = assignmentTextField.text!
        let dueDate: Date = datePicker.date
        
        //assign locally entered info into the assignment in course store in the right course
        let newAssignment = Assignment(name: assignmentName, date: dueDate)
        course.assignmentArray.append(newAssignment)
        
        //if there is an image for the current assignment
        if imageView.image != nil {
            imageStore.setImage(imageView.image!, forKey: course.assignmentArray[localRow].pictureKey)
        }
        //clear the text after add button is clicked
        assignmentTextField.text = ""
        dueDateTextField.text = ""
        //must reset the values of these to nothing so that the next addition doesn't carry them
        
        imageView.image = nil
        
        //prepare for notifications
        let center = UNUserNotificationCenter.current()
        
        //6 hour trigger content
        let content6 = UNMutableNotificationContent()
        content6.title = assignmentName
        content6.body = "Due in 6 hours!"
        content6.sound = UNNotificationSound.default()
        
        //12 hour trigger content
        let content12 = UNMutableNotificationContent()
        content12.title = assignmentName
        content12.body = "Due in 12 hours!"
        content12.sound = UNNotificationSound.default()
        
        //24 hour trigger content
        let content24 = UNMutableNotificationContent()
        content24.title = assignmentName
        content24.body = "Due in 24 hours!"
        content24.sound = UNNotificationSound.default()
        
        //format the date for the trigger - 6 hr
        let triggerDate6 = datePicker.date.addingTimeInterval(-21600)
        let triggerDate6Components = Calendar.current.dateComponents([.year,.month,.day,.hour,.minute,.second,], from: triggerDate6)
        let trigger6 = UNCalendarNotificationTrigger(dateMatching: triggerDate6Components, repeats: false)

        //format the date for the trigger - 12 hr
        let triggerDate12 = datePicker.date.addingTimeInterval(-43200)
        let triggerDate12Components = Calendar.current.dateComponents([.year,.month,.day,.hour,.minute,.second,], from: triggerDate12)
        let trigger12 = UNCalendarNotificationTrigger(dateMatching: triggerDate12Components, repeats: false)

        //format the date for the trigger - 24 hr
        let triggerDate24 = datePicker.date.addingTimeInterval(-86400)
        let triggerDate24Components = Calendar.current.dateComponents([.year,.month,.day,.hour,.minute,.second,], from: triggerDate24)
        let trigger24 = UNCalendarNotificationTrigger(dateMatching: triggerDate24Components, repeats: false)

        
        //finally craft and set up the notification - 6 hr
        let identifier6 = "UYLLocalNotification6hr"
        let request6 = UNNotificationRequest(identifier: identifier6,
                                            content: content6, trigger: trigger6)
        center.add(request6, withCompletionHandler: { (error) in
            if error != nil {
                // Something went wrong
            }
        })
        
        //finally craft and set up the notification - 12 hr
        let identifier12 = "UYLLocalNotification12hr"
        let request12 = UNNotificationRequest(identifier: identifier12,
                                             content: content12, trigger: trigger12)
        center.add(request12, withCompletionHandler: { (error) in
            if error != nil {
                // Something went wrong
            }
        })
        
        //finally craft and set up the notification - 24 hr
        let identifier24 = "UYLLocalNotification24hr"
        let request24 = UNNotificationRequest(identifier: identifier24,
                                             content: content24, trigger: trigger24)
        center.add(request24, withCompletionHandler: { (error) in
            if error != nil {
                // Something went wrong
            }
        })
        
        //now that notifications are done, close out of the segue finally
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if senderID == 2 {
            addButton.isHidden = true
            cancelButton.isHidden = true
            
            assignmentTextField.text = course.assignmentArray[localRow].name
            dueDateTextField.text = DateFormatter.localizedString(from: course.assignmentArray[localRow].date, dateStyle: .short, timeStyle: .short)

        let key = course.assignmentArray[localRow].pictureKey
        
        // If there is an associated image with the item ...
        if let imageToDisplay = imageStore.image(forKey: key) {
            // ... display it on the image view
            imageView.image = imageToDisplay
        }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        //save any changes that they make, only if they are in "editing mode" detected by sender ID 2
        if senderID == 2 {
            course.assignmentArray[localRow].name = assignmentTextField.text ?? ""
            if imageView.image != nil {
                imageStore.setImage(imageView.image!, forKey: course.assignmentArray[localRow].pictureKey)
                       }
            if (datePicker != nil){
            course.assignmentArray[localRow].date = (datePicker.date)
            }
            else
            {
                course.assignmentArray[localRow].date = course.assignmentArray[localRow].date
            }
        }
    }
    
    @IBAction func takePicture(_ sender: UIBarButtonItem) {
        let imagePicker = UIImagePickerController()
        
        // If the device has a camera, take a picture, otherwise,
        // just pick from photo library
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            imagePicker.sourceType = .camera
        }
        else {
            imagePicker.sourceType = .photoLibrary
        }
        
        imagePicker.delegate = self
        // Place image picker on the screen
        present(imagePicker, animated: true, completion: nil)
        
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.pickUpDate(self.dueDateTextField)
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String: Any]) {
        
        // Get picked image from info dictionary
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        // Store the image in the ImageStore for the item's key
        
//        if course.assignmentArray.count != 0 {
//        imageStore.setImage(image, forKey: course.assignmentArray[localRow].pictureKey)
//       }
        // Put that image onto the screen in our image view
        imageView.image = image
        
        // Take image picker off the screen -
        // you must call this dismiss method
        dismiss(animated: true, completion: nil)
    }
    
    func pickUpDate(_ textField : UITextField){
        
        // DatePicker
        self.datePicker = UIDatePicker(frame:CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 216))
        self.datePicker.backgroundColor = UIColor.white
        self.datePicker.datePickerMode = UIDatePickerMode.dateAndTime
        textField.inputView = self.datePicker
        
        // ToolBar
        let toolBar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor(red: 92/255, green: 216/255, blue: 255/255, alpha: 1)
        toolBar.sizeToFit()
        
        // Adding Button ToolBar
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(AddAssignmentViewController.doneClick))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(AddAssignmentViewController.cancelClick))
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        textField.inputAccessoryView = toolBar
    }
    
    @objc func doneClick() {
        let dateFormatter1 = DateFormatter()
        dateFormatter1.dateStyle = .medium
        dateFormatter1.timeStyle = .short
        dueDateTextField.text = dateFormatter1.string(from: datePicker.date)
        dueDateTextField.resignFirstResponder()
        
        //assign the date
        localDate = datePicker.date
    }
    @objc func cancelClick() {
        dueDateTextField.resignFirstResponder()
    }
   
    
}

