//
//  BudgetViewController.swift
//  Demo
//
//  Created by Ben Vickers on 09/10/2016.
//  Copyright © 2016 Ben Vickers. All rights reserved.
//

import UIKit

class BudgetViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    //Mark: Properties
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var saveButton: UIBarButtonItem!
   // @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var amountTextField: UITextField!
    
    /*
    This value is either passed by 'AccountsViewController' in 'prepareForSegue(_:sender:)'
     or constructed as part of adding a new budget.
     */
    var budget:Budget?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //BudgetDataModel.deleteall()
        
        //BudgetDataModel.GetInitialBudgets()
        amountTextField.keyboardType = UIKeyboardType.decimalPad
    
        // Handle the text field's user input through delegate callbacks
        nameTextField.delegate = self
        
        //Enable the save button only if the text field has a valid budget name.
       // checkValidBudgetName()
        
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: self.view.frame.size.height/6, width: self.view.frame.size.width, height: 40.0))
        
        toolBar.layer.position = CGPoint(x: self.view.frame.size.width/2, y: self.view.frame.size.height-20.0)
        toolBar.barStyle = UIBarStyle.blackOpaque
        toolBar.tintColor = UIColor.white
        toolBar.barTintColor = UIColor(red: 234.0/255.0, green: 101.0/255.0, blue: 51.0/255.0, alpha: 1.0)
        toolBar.backgroundColor = UIColor.orange
        toolBar.isTranslucent = false;
        
        
        let okBarBtn = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: self, action: #selector(BudgetViewController.donePressed))
        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: self, action: nil)
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width / 3, height: self.view.frame.size.height))
        
        label.font = UIFont(name: "Helvetica", size: 14)
        label.backgroundColor = UIColor.clear
        label.textColor = UIColor.white
        label.textAlignment = NSTextAlignment.center
        
        let textBtn = UIBarButtonItem(customView: label)
        toolBar.setItems([textBtn,flexSpace,okBarBtn], animated: true)
        amountTextField.inputAccessoryView = toolBar
        nameTextField.inputAccessoryView = toolBar
        
        
        //Border colors
        nameTextField.layer.borderColor = UIColor.white.cgColor
        nameTextField.layer.borderWidth = 2
        amountTextField.layer.borderColor = UIColor.white.cgColor
        amountTextField.layer.borderWidth = 2
        
        //Set up views if editing an existing Budget.
        if let budget = budget{
            navigationItem.title = budget.name
            nameTextField.text = budget.name
            //amountTextField.text = budget.amount
            
            amountTextField.text = ("\(budget.amount)")
            amountTextField.becomeFirstResponder()
        }
    }

    //Mark: UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //Hide the keyboard
        textField.resignFirstResponder()
        return true
    }
    
    //Local functions
    func donePressed(_ sender: UIBarButtonItem) {
        amountTextField.resignFirstResponder()
        nameTextField.resignFirstResponder()
        checkValidBudgetName()
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField){
        //Disable the save button while editing.
    saveButton.isEnabled = false
    }
    
    func checkValidBudgetName(){
        //Disable the save button if the text field is empty
        let text = nameTextField.text ?? ""
        let text2 = Double(amountTextField.text!)
        saveButton.isEnabled = (!text.isEmpty && (text2 != nil))
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        checkValidBudgetName()
        navigationItem.title = textField.text
    }
    
    /*MARK: UIImagePickerControllerDelegate
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        //Dismiss the picker if the user cancelled
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        //The info dictionary contains multiple representations of the image, and this uses the original
        let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage
        
        //Set photoImageView to display the selected image
        photoImageView.image = selectedImage
        
        //Dismiss the picker
        dismiss(animated: true, completion: nil)
    }*/
    
    //MARK: Navigation
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        //Depending on style of presentation (modal or push presentation), this view controller needs to be dismissed in two different ways.
        let isPresentingInAddBudgetMode = presentingViewController is UITabBarController
        if isPresentingInAddBudgetMode
            {
                self.dismiss(animated: true, completion: nil)
            }
            else
            {
                navigationController!.popViewController(animated: true)
            }
        }
    
    //This method lets you configure a view controller before it's presented.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if sender as AnyObject? === saveButton {
            //_ = nameTextField.text ?? ""
           // _ = Double(amountTextField.text!)
            
            let name = nameTextField.text ?? ""
            //let photo = photoImageView.image
            let amount = Double(amountTextField.text!)
            
            //Set the budget to be passed to AccountsViewController after the unwind segue
            budget = Budget(name: name, /*photo: photo,*/ amount: amount!)
        }
    }
    
    //Mark: Actions
    @IBAction func selectImageFromPhotoLibrary(_ sender: UITapGestureRecognizer) {
        
        // Hide the keyboard.
        nameTextField?.resignFirstResponder()
        amountTextField?.resignFirstResponder()
        
        // UIImagePickerController is a view controller that lets a user pick media from their photo library.
        let imagePickerController = UIImagePickerController()
        
        // Only allow photos to be picked, not taken.
        imagePickerController.sourceType = .photoLibrary
        
        // Make sure ViewController is notified when the user picks an image.
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
    }
}
    
    
/*extension UITextField{
    @IBInspectable var placeHolderColor: UIColor? {
        get {
            return self.placeHolderColor
        }
        set {
            self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "", attributes:[NSForegroundColorAttributeName: newValue!])
        }
    }

}*/

