//
//  ExpensesViewController.swift
//  My P&L
//
//  Created by Ben Vickers on 06/04/2017.
//  Copyright © 2017 Ben Vickers. All rights reserved.
//
import UIKit

class ExpensesViewController: UIViewController, UITextFieldDelegate, UINavigationControllerDelegate {
    
    //Mark: Properties
    @IBOutlet weak var expensenameTextField: UITextField!
    @IBOutlet weak var expenseamountTextField: UITextField!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var expensedateTextField: UITextField!
    
    /*
     This value is either passed by 'AccountsViewController' in 'prepareForSegue(_:sender:)'
     or constructed as part of adding a new budget.
     */
    var expense:Expense?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //BudgetDataModel.deleteall()
        
        expenseamountTextField.keyboardType = UIKeyboardType.decimalPad
        
        // Handle the text field's user input through delegate callbacks
        expensenameTextField.delegate = self
        
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
        expenseamountTextField.inputAccessoryView = toolBar
        expensenameTextField.inputAccessoryView = toolBar
        expensedateTextField.inputAccessoryView = toolBar
        
        
        //Border colors
        expensenameTextField.layer.borderColor = UIColor.white.cgColor
        expensenameTextField.layer.borderWidth = 2
        expenseamountTextField.layer.borderColor = UIColor.white.cgColor
        expenseamountTextField.layer.borderWidth = 2
        expensedateTextField.layer.borderColor = UIColor.white.cgColor
        expensedateTextField.layer.borderWidth = 2
        
        //Set up views if editing an existing Budget.
        if let expense = expense{
            navigationItem.title = expense.expensename
            expensenameTextField.text = expense.expensename
            //amountTextField.text = budget.amount
            
            expenseamountTextField.text = ("\(expense.expenseamount)")
            expenseamountTextField.becomeFirstResponder()
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
        expenseamountTextField.resignFirstResponder()
        expensenameTextField.resignFirstResponder()
        checkValidExpenseName()
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField){
        //Disable the save button while editing.
        saveButton.isEnabled = false
    }
    
    func checkValidExpenseName(){
        //Disable the save button if the text field is empty
        let text = expensenameTextField.text ?? ""
        let text2 = Double(expenseamountTextField.text!)
        saveButton.isEnabled = (!text.isEmpty && (text2 != nil))
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        checkValidExpenseName()
        navigationItem.title = textField.text
    }
    
    
    //Actions
    
    // Action to bring up the date picker on editing
    
    @IBAction func expensedateediting(_ sender: UITextField) {
        let datePickerView:UIDatePicker = UIDatePicker()
        
        datePickerView.datePickerMode = UIDatePickerMode.date
        sender.inputView = datePickerView
        datePickerView.addTarget(self, action: #selector(ExpensesViewController.datePickerValueChanged), for: UIControlEvents.valueChanged)
        expensedateTextField.text = BudgetDataModel.formatter.string(from: Date())
    }
    
        //Action to change the date picker value when selected
        func datePickerValueChanged(sender:UIDatePicker) {
        
        BudgetDataModel.formatter.dateStyle = DateFormatter.Style.full
        BudgetDataModel.formatter.timeStyle = DateFormatter.Style.none
        BudgetDataModel.formatter.timeZone = TimeZone(abbreviation: "GMT+0:00")
        expensedateTextField.text = BudgetDataModel.formatter.string(from: sender.date)
        
        ExpensesDataModel.expenseday = expensedateTextField.text!
        }
    
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
            
            let expensename = expensenameTextField.text ?? ""
            //let photo = photoImageView.image
            let expenseamount = Double(expenseamountTextField.text!)
            let expensedate = expensedateTextField.text ?? ""
            
            //Set the budget to be passed to AccountsViewController after the unwind segue
            expense = Expense(expensename: expensename, /*photo: photo,*/ expenseamount: expenseamount!, expensedate: expensedate)
        }
    }
    
}
extension UITextField{
    @IBInspectable var placeHolderColor: UIColor? {
        get {
            return self.placeHolderColor
        }
        set {
            self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "", attributes:[NSForegroundColorAttributeName: newValue!])
        }
    }
    
}
