//
//  AddAssignmentViewController.swift
//  StudentAssistant
//
//  Created by Alixa Bahena on 11/17/17.
//  Copyright © 2017 AlixaBahena. All rights reserved.
//

import UIKit

class AddAssignmentViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    @IBOutlet var assignmentTextField: UITextField!
    @IBOutlet var dueDateTextField: UITextField!
    @IBOutlet var imageView: UIImageView!
    var imageStore: ImageStore!
    var datePicker : UIDatePicker!
    var course: Course!
    var courseStore: CourseStore!
    var localDate: Date!
    var localRow: Int = 0
    
    
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
        
        //pull information the user entered and make it locally availabl
        let assignmentName: String = assignmentTextField.text!
        let dueDate: Date = datePicker.date
        
        //assign locally entered info into the assignment in course store in the right course
        let newAssignment = Assignment(name: assignmentName, date: dueDate)
        course.assignmentArray.append(newAssignment)
        if imageView.image != nil {
            imageStore.setImage(imageView.image!, forKey: course.assignmentArray[localRow].pictureKey)
        }
        //clear the text after add button is clicked
        assignmentTextField.text = ""
        dueDateTextField.text = ""
        imageView.image = nil
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
       
        if course.assignmentArray.count != 0 {
            assignmentTextField.text = course.assignmentArray[localRow].name
            dueDateTextField.text = dateFormatter.string(from: course.assignmentArray[localRow].date)
            
            
        let key = course.assignmentArray[localRow].pictureKey
        
        // If there is an associated image with the item ...
        if let imageToDisplay = imageStore.image(forKey: key) {
            // ... display it on the image view
            imageView.image = imageToDisplay
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
        
        if course.assignmentArray.count != 0 {
        imageStore.setImage(image, forKey: course.assignmentArray[localRow].pictureKey)
        }
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

