//
//  PayDayViewController.swift
//  My P&L
//
//  Created by Ben Vickers on 15/03/2017.
//  Copyright © 2017 Ben Vickers. All rights reserved.
//

import UIKit

class PayDayViewController: UIViewController {
    
    // Property for the payday text field
    @IBOutlet weak var paydaydateTextField: UITextField!
    
    var tempdate = String()

    
    //Load the page
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: self.view.frame.size.height/6, width: self.view.frame.size.width, height: 40.0))
        
        toolBar.layer.position = CGPoint(x: self.view.frame.size.width/2, y: self.view.frame.size.height-20.0)
        toolBar.barStyle = UIBarStyle.blackOpaque
        toolBar.tintColor = UIColor.white
        toolBar.barTintColor = UIColor(red: 234.0/255.0, green: 101.0/255.0, blue: 51.0/255.0, alpha: 1.0)
        toolBar.backgroundColor = UIColor.orange
        toolBar.isTranslucent = false;
        
        
        let todayBtn = UIBarButtonItem(title: "Today", style: UIBarButtonItemStyle.plain, target: self, action: #selector(PayDayViewController.tappedToolBarBtn))
        let okBarBtn = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: self, action: #selector(PayDayViewController.donePressed))
        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: self, action: nil)
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width / 3, height: self.view.frame.size.height))
        
        label.font = UIFont(name: "Helvetica", size: 14)
        label.backgroundColor = UIColor.clear
        label.textColor = UIColor.white
        label.textAlignment = NSTextAlignment.center
        
        let textBtn = UIBarButtonItem(customView: label)
        toolBar.setItems([todayBtn,flexSpace,textBtn,flexSpace,okBarBtn], animated: true)
        paydaydateTextField.inputAccessoryView = toolBar
        
        //Border colors
        paydaydateTextField.layer.borderColor = UIColor.white.cgColor
        paydaydateTextField.layer.borderWidth = 2
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //Local functions
    func donePressed(_ sender: UIBarButtonItem) {
        paydaydateTextField.resignFirstResponder()
        BudgetDataModel.formatter.dateStyle = DateFormatter.Style.full
        BudgetDataModel.formatter.timeStyle = DateFormatter.Style.none
        BudgetDataModel.formatter.timeZone = TimeZone(abbreviation: "GMT+0:00")
    }
    
    func tappedToolBarBtn(_ sender: UIBarButtonItem) {
        BudgetDataModel.formatter.dateStyle = DateFormatter.Style.full
        BudgetDataModel.formatter.timeStyle = DateFormatter.Style.none
        BudgetDataModel.formatter.timeZone = TimeZone(abbreviation: "GMT+0:00")
        paydaydateTextField.text = BudgetDataModel.formatter.string(from: Date())
        paydaydateTextField.resignFirstResponder()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    //Actions
    
    // Action to bring up the date picker on editing
    @IBAction func paydayEditing(_ sender: UITextField) {
        let datePickerView:UIDatePicker = UIDatePicker()
        
        datePickerView.datePickerMode = UIDatePickerMode.date
        sender.inputView = datePickerView
        datePickerView.addTarget(self, action: #selector(PayDayViewController.datePickerValueChanged), for: UIControlEvents.valueChanged)
        paydaydateTextField.text = BudgetDataModel.formatter.string(from: Date())
        //paydaydateTextField.text = PaydayDataModel.payday
    }

    //Action to remove the date picker when finishing editing
    @IBAction func paydayEditingdidEnd(_ sender: Any) {
         paydaydateTextField.resignFirstResponder()
    }
    
    //Action to change the date picker value when selected
    func datePickerValueChanged(sender:UIDatePicker) {
    
        BudgetDataModel.formatter.dateStyle = DateFormatter.Style.full
        BudgetDataModel.formatter.timeStyle = DateFormatter.Style.none
        BudgetDataModel.formatter.timeZone = TimeZone(abbreviation: "GMT+0:00")
        paydaydateTextField.text = BudgetDataModel.formatter.string(from: sender.date)
         
        PaydayDataModel.payday = paydaydateTextField.text!
        //***PayDayDataModel.date = paydaydateTextField.text!
    }

    @IBAction func savePayday(_ sender: Any) {
        PaydayDataModel.payday = paydaydateTextField.text!
        UserDefaults.standard.set(paydaydateTextField.text, forKey: "savedStringKey")
        UserDefaults.standard.synchronize()
        BudgetDataModel.convertedDate = BudgetDataModel.formatter.date(from: PaydayDataModel.payday)!
        print (BudgetDataModel.convertedDate)
        BudgetDataModel.calculatedays()
        paydaydateTextField.resignFirstResponder()
        
        
        //Add an alert for saving the payday
        let alertController = UIAlertController(title: "Your P&L", message:
         "Payday Added!", preferredStyle: UIAlertControllerStyle.alert)
         alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default,handler: nil))
         
         self.present(alertController, animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

