//
//  ExpendituresDataModel.swift
//  My P&L
//
//  Created by Ben Vickers on 06/04/2017.
//  Copyright © 2017 Ben Vickers. All rights reserved.
//

import Foundation

import os.log

var ExpensesDataModel = ExpDataModel()

class ExpDataModel {
    
    //Properties
    var expenses = [Expense]()
    var expensestotal : Double = 0.0
    var expenseday : String = ""


    //Functions
    
    // Calculate expensestotal
    func calculateExpensesTotal() {
        expensestotal = 0
        for (element) in expenses
        {
            expensestotal += element.expenseamount
        }
    }

    
    //Saving budgets
    func saveExpenses(){
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(expenses, toFile: Expense.ArchiveURL.path)
        
        if isSuccessfulSave{
            os_log("Expenses successfully saved.", log: OSLog.default, type: .debug)
        }else if !isSuccessfulSave {
            print("Failed to save expenses...")
            os_log("Failed to save expenses...", log: OSLog.default, type: .debug)
        }
    }
    
    
    //Loading expenses
    func loadExpenses() -> [Expense]?{
        print("Loading the original expenses data")
        return NSKeyedUnarchiver.unarchiveObject(withFile: Expense.ArchiveURL.path) as? [Expense]
    }
    
    //Load the inital expenses
    func GetInitialExpenses(){
        if let savedExpenses = loadExpenses(){
            expenses += savedExpenses
        }
        else{
            //Load the sample data.
            print("Failed to load data")
        }
    }

    
}
