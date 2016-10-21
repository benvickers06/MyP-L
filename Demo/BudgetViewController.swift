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
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var saveButton: UIBarButtonItem!

    
    /*
    This value is either passed by 'BudgetTableViewController' in 'prepareForSegue(_:sender:)'
     or constructed as part of adding a new budget.
     */
    var budget:Budget?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        // Handle the text field's user input through delegate callbacks
        nameTextField.delegate = self
        
        //Enable the save button only if the text field has a valid budget name.
        checkValidBudgetName()
        
        //Set up views if editing an existing Budget.
        if let budget = budget{
            navigationItem.title = budget.name
            nameTextField.text = budget.name
            photoImageView.image = budget.photo
        }
    }

    //Mark: UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //Hide the keyboard
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(textField: UITextField){
        //Disable the save button while editing.
    saveButton.isEnabled = false
    }
    
    func checkValidBudgetName(){
        //Disable the save button if the text field is empty
        let text = nameTextField.text ?? ""
        saveButton.isEnabled = !text.isEmpty
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        checkValidBudgetName()
        navigationItem.title = textField.text
    }
    
    //MARK: UIImagePickerControllerDelegate
    
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
    }
    
    //MARK: Navigation
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        //Depending on style of presentation (modal or push presentation), this view controller needs to be dismissed in two different ways.
        let isPresentingInAddBudgetMode = presentingViewController is UINavigationController
        
        if isPresentingInAddBudgetMode{
            dismiss(animated: true, completion: nil)
        }
        else {
            navigationController!.popViewController(animated: true)
        }
    }
    
    //This method lets you configure a view controller before it's presented.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if sender as AnyObject? === saveButton {
            let name = nameTextField.text ?? ""
            let photo = photoImageView.image
            
            //Set the budget to be passed to BudgetTableViewController after the unwind segue
            budget = Budget(name: name, photo: photo)
        }
    }
    
    //Mark: Actions
    @IBAction func selectImageFromPhotoLibrary(_ sender: UITapGestureRecognizer) {
        //Hide the keyboard
        nameTextField.resignFirstResponder()
        
        //UIImagePickerController is a view controller that lets a user pick media from their photo library
        let imagePickerController = UIImagePickerController()
        
        //Only allows photos to be picked, not taken.
        imagePickerController.sourceType = .photoLibrary
        
        //Make sure ViewController is notified when the user picks an image.
        imagePickerController.delegate = self
        
        present(imagePickerController, animated: true, completion: nil)
    }
}

