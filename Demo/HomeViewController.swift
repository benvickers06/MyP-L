//
//  HomeViewController.swift
//  My P&L
//
//  Created by Ben Vickers on 14/03/2017.
//  Copyright © 2017 Ben Vickers. All rights reserved.
//

import UIKit
import LocalAuthentication

class HomeViewController: UIViewController {

    //Properties
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var savingstotalLabel: UILabel!
    @IBOutlet weak var todaysDateLabel: UILabel!
    @IBOutlet weak var paydayDateLabel: UILabel!
    @IBOutlet weak var dailyspendLabel: UILabel!
    @IBOutlet weak var paydayDaysLabel: UILabel!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Only uncomment if I need to delete the data in the archive/array
            // BudgetDataModel.deleteall()
        print("Loading HomeView Controller")
        
    }
    
    //After loading the screen, present the following
    override func viewDidAppear(_ animated: Bool) {
        
        totalLabel.text = ("Total Current Standings: £\(BudgetDataModel.returnTrueValue(number: BudgetDataModel.total))")
        todaysDateLabel.text = ("\(BudgetDataModel.getTodaysDate(result: BudgetDataModel.todaysDate))")
        if let x = UserDefaults.standard.object(forKey: "savedStringKey") as? String
            {
                paydayDateLabel.text = ("Payday: \(x)")
                BudgetDataModel.convertedDate = BudgetDataModel.formatter.date(from: x)!
            }
        BudgetDataModel.calculatedays()
        dailyspendLabel.text = ("Spend per day: £\(BudgetDataModel.returnTrueValue(number: BudgetDataModel.DailySpend))")
        SavingsDataModel.calculateSavingsTotal()
        savingstotalLabel.text = ("Total Savings: £\(BudgetDataModel.returnTrueValue(number: SavingsDataModel.savingstotal))")
        paydayDaysLabel.text = ("Number of days till payday: \(BudgetDataModel.paydayDays)")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
