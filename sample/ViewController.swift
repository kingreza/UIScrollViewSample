//
//  ViewController.swift
//  sample
//
//  Created by Reza Shirazian on 6/23/17.
//  Copyright © 2017 YourMechanic. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

  
  @IBOutlet weak var inputOne: UITextField!
  
  @IBOutlet weak var inputTwo: UITextField!
  
  @IBOutlet weak var inputThree: UITextField!
  
  @IBOutlet weak var inputFour: UITextField!
  
  
  @IBOutlet weak var inputFive: UITextField!
  @IBOutlet weak var inputSix: UITextField!
  
  @IBOutlet weak var inputSeven: UITextField!
  
  @IBOutlet weak var inputEight: UITextField!
  
  @IBOutlet weak var scrollView: UIScrollView!
  var activeField: UITextField?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    let inputs = [inputOne, inputTwo, inputThree, inputFour, inputFive, inputSix, inputSeven, inputEight]
    inputs.forEach{$0?.delegate = self}
    registerForKeyboardNotifications()
    // Do any additional setup after loading the view, typically from a nib.
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  func registerForKeyboardNotifications(){
    //Adding notifies on keyboard appearing
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWasShown(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillBeHidden(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
  }
  
  func deregisterFromKeyboardNotifications(){
    //Removing notifies on keyboard appearing
    NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
    NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
  }
  
  func keyboardWasShown(notification: NSNotification){
    //Need to calculate keyboard exact size due to Apple suggestions
    var info = notification.userInfo!
    let keyboardSize = (info[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue.size
    let contentInsets : UIEdgeInsets = UIEdgeInsetsMake(0.0, 0.0, keyboardSize!.height, 0.0)
    
    self.scrollView.contentInset = contentInsets
    self.scrollView.scrollIndicatorInsets = contentInsets
    
    var aRect : CGRect = self.view.frame
    aRect.size.height -= keyboardSize!.height
    if let activeField = self.activeField {
      if (!aRect.contains(activeField.frame.origin)){
        self.scrollView.scrollRectToVisible(activeField.frame, animated: true)
      }
    }
  }
  
  func keyboardWillBeHidden(notification: NSNotification){
    //Once keyboard disappears, restore original positions

  }
  
  func textFieldDidBeginEditing(_ textField: UITextField){
    activeField = textField
  }
  
  func textFieldDidEndEditing(_ textField: UITextField){
    activeField = nil
  }

}

