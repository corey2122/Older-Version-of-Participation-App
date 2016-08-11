//
//  StudentViewController.swift
//  ParticipationApp
//
//  Created by CJS  on 7/23/16.
//  Copyright © 2016 CJS . All rights reserved.
//

import UIKit

class StudentViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var pointsTextField: UITextField!
    @IBOutlet weak var commentsTextField: UITextField!
    @IBOutlet weak var editSaveButton: UIBarButtonItem!
    
    var editButton: Bool = false
    var detailItem: AnyObject? {
        didSet {
            // Update the view.
                  }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
     print("view loaded")
        //Looks for single or multiple taps.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(StudentViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        textFieldDeactive()
    }
    
    @IBAction func editButtonPressed(sender: UIBarButtonItem) {
        editButton = !editButton //switches button ON/OFF
        
   
        if editButton {
//          editButton = false
            self.editSaveButton.title = "Save"
             textFieldActive()
            // UIBarButtonItem(title: "Save", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(DetailViewController.editButton(_:)))
            
        } else {
            self.editSaveButton.title = "Edit"
            //UIBarButtonItem(title: "Edit", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(DetailViewController.editButton(_:)))
//            editButton = true
            textFieldDeactive()
        }
    }
    
    //hook up IBOutlets//////
    //make IBAction for edit save button
    //change textrield from enable to disable
    //change button form edit/aave
    //print to council values of textfield



func textFieldActive(){
    //Changes border style
    nameTextField.setBoarder()
    pointsTextField.setBoarder()
    commentsTextField.setBoarder()
}

func  textFieldDeactive(){
   
    
    nameTextField.removeBoarder()
    pointsTextField.removeBoarder()
    commentsTextField.removeBoarder()
}
       

//Calls this function when the tap is recognized.
func dismissKeyboard() {
    //Causes the view (or one of its embedded text fields) to resign the first responder status.
    view.endEditing(true)
    
}

override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
}

}

extension UITextField {
    func setBoarder() {
        self.userInteractionEnabled = true
        self.layer.cornerRadius = 8
        self.layer.borderColor = UIColor.grayColor().CGColor
        self.layer.borderWidth = 2
        // etc.
    }
    
    func removeBoarder() {
        self.userInteractionEnabled = false
        self.layer.cornerRadius = 0
        self.layer.borderColor = UIColor.clearColor().CGColor
        self.layer.borderWidth = 0
        // etc.
    }
}
