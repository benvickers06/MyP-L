//
//  SavingsViewController.swift
//  My P&L
//
//  Created by Ben Vickers on 17/03/2017.
//  Copyright © 2017 Ben Vickers. All rights reserved.
//

import UIKit

class SavingsViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var savingsaccountTextField: UITextField!
    @IBOutlet weak var savingsamountTextField: UITextField!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    var saving: Saving?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        savingsamountTextField.keyboardType = UIKeyboardType.decimalPad
        
        //
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: self.view.frame.size.height/6, width: self.view.frame.size.width, height: 40.0))
        
        toolBar.layer.position = CGPoint(x: self.view.frame.size.width/2, y: self.view.frame.size.height-20.0)
        toolBar.barStyle = UIBarStyle.blackOpaque
        toolBar.tintColor = UIColor.white
        toolBar.barTintColor = UIColor(red: 234.0/255.0, green: 101.0/255.0, blue: 51.0/255.0, alpha: 1.0)
        toolBar.backgroundColor = UIColor.orange
        toolBar.isTranslucent = false;
        
        
        
        let okBarBtn = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: self, action: #selector(SavingsViewController.donePressed))
        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: self, action: nil)
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width / 3, height: self.view.frame.size.height))
        
        label.font = UIFont(name: "Helvetica", size: 14)
        label.backgroundColor = UIColor.clear
        label.textColor = UIColor.white
        label.textAlignment = NSTextAlignment.center
        
        let textBtn = UIBarButtonItem(customView: label)
        toolBar.setItems([textBtn,flexSpace,okBarBtn], animated: true)
        savingsamountTextField.inputAccessoryView = toolBar
        savingsaccountTextField.inputAccessoryView = toolBar


        
        // Handle the text field's user input through delegate callbacks
        savingsaccountTextField.delegate = self
        
        //Border colors
        savingsaccountTextField.layer.borderColor = UIColor.white.cgColor
        savingsaccountTextField.layer.borderWidth = 2
        savingsamountTextField.layer.borderColor = UIColor.white.cgColor
        savingsamountTextField.layer.borderWidth = 2
        
        //Set up views if editing an existing Budget.
        if let saving = saving{
            navigationItem.title = saving.savingname
            savingsaccountTextField.text = saving.savingname
            //amountTextField.text = budget.amount
            
            savingsamountTextField.text = ("\(saving.savingamount)")
            savingsamountTextField.becomeFirstResponder()

        }

    }
    
    //Local functions
    func donePressed(_ sender: UIBarButtonItem) {
        savingsamountTextField.resignFirstResponder()
        savingsaccountTextField.resignFirstResponder()
        checkValidSavingName()
     }

    
    
    //Mark: UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //Hide the keyboard
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField){
        //Disable the save button while editing.
        saveButton.isEnabled = false
    }
    
    func checkValidSavingName(){
        //Disable the save button if the text field is empty
        let text = savingsaccountTextField.text ?? ""
        let text2 = Double(savingsamountTextField.text!)
        saveButton.isEnabled = (!text.isEmpty && (text2 != nil))
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        checkValidSavingName()
        navigationItem.title = textField.text
    }
    
    //MARK: Navigation

    @IBAction func cancel(_ sender: UIBarButtonItem) {
        //Depending on style of presentation (modal or push presentation), this view controller needs to be dismissed in two different ways.
        let isPresentingInAddSavingMode = presentingViewController is UITabBarController
        
        if isPresentingInAddSavingMode{
            dismiss(animated: true, completion: nil)
        }
        else {
            navigationController!.popViewController(animated: true)
        }
    }
    
    //This method lets you configure a view controller before it's presented.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if sender as AnyObject? === saveButton {
        
            let savingname = savingsaccountTextField.text ?? ""
            let savingamount = Double(savingsamountTextField.text!)
            
            //Set the budget to be passed to SavingTableViewController after the unwind segue
            saving = Saving(savingname: savingname, savingamount: savingamount!)
        }
    }
}
