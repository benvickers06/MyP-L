//
//  BudgetDataModel.swift
//  My P&L
//
//  Created by Ben Vickers on 14/03/2017.
//  Copyright © 2017 Ben Vickers. All rights reserved.
//

import Foundation

import os.log

var BudgetDataModel = DataModel()

class DataModel {
    
    //Properties
    var total : Double = 0.0
    var budgets = [Budget]()
    let todaysDate = Date()
    let formatter = DateFormatter()
    var convertedDate = Date()
    var NumOfDays : Double = 0.0
    var DailySpend : Double = 0.0
    var paydayDays = 0
    
    // Calculate total
    func calculateTotalStandings() {
        
        total = 0
        for (element) in budgets{
            total += element.amount
        }
    }
    
    //Only use for deleting an array data
    func deleteall(){
        budgets.removeAll()
        print("Deleting all data from budgets array")
        saveBudgets()
        }

    
    //Saving budgets
    func saveBudgets(){
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(budgets, toFile: Budget.ArchiveURL.path)
        
        if isSuccessfulSave{
            os_log("Budgets successfully saved.", log: OSLog.default, type: .debug)
        }else if !isSuccessfulSave {
            print("Failed to save budgets...")
            os_log("Failed to save budgets...", log: OSLog.default, type: .debug)
        }
    }
    
    
    //Loading budgets
    func loadBudgets() -> [Budget]?{
        print("Loading the original budgets data")
        return NSKeyedUnarchiver.unarchiveObject(withFile: Budget.ArchiveURL.path) as? [Budget]
    }
    
    //Load the inital budgets
    func GetInitialBudgets(){
        if let savedBudgets = loadBudgets(){
            budgets += savedBudgets
        }
        else{
            //Load the sample data.
            loadSampleBudgets()
        }
    }
    
    //Loading the sample budgets array
    func loadSampleBudgets(){
        print("Couldn't load original data, so loading sample data")
        let budget1 = Budget(name: "Rent", /*photo: photo1,*/ amount: 1500)!
        let budget2 = Budget(name: "Bills", /*photo: photo2,*/ amount: 600)!
        let budget3 = Budget(name: "Groceries", /*photo: photo3,*/ amount: 40)!
        budgets += [budget1, budget2, budget3]
    }
    
    //Returning a string from a double number
    func returnTrueValue(number:Double) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = NumberFormatter.Style.decimal
        return (numberFormatter.string(from: NSNumber(value: number)))!
    }
    
    //Get todays date into a string
    func getTodaysDate(result:Date) -> String {
        formatter.dateStyle = DateFormatter.Style.full
        formatter.timeStyle = DateFormatter.Style.none
        let result = formatter.string(from: todaysDate)
        return (result)
    }
    
    //Format date into a string
    func dateformatting(){
        formatter.dateStyle = DateFormatter.Style.full
        formatter.timeStyle = DateFormatter.Style.none
        formatter.timeZone = TimeZone(abbreviation: "GMT+0:00")
    }
    
    // Difference between dates
    func daysBetweenDates(startDate: Date, endDate: Date) -> Double {
        let calendar = Calendar.current
        let components = calendar.dateComponents([Calendar.Component.day], from: startDate, to: endDate)
        return Double(components.day!)
    }
    
    //Working out the number of days between todays date and the paydate given
    func calculatedays() {
        var NumOfDays: Double = daysBetweenDates(startDate: todaysDate, endDate: convertedDate)
        NumOfDays = NumOfDays + 1
        calculateSpendPerDay()
        DailySpend = (total / NumOfDays)
        paydayDays = Int(NumOfDays)
    }
    
    //Calculating the spend per day
    func calculateSpendPerDay(){
        DailySpend = (total / NumOfDays)
    }
    
    public static func daysBetween(start: Date, end: Date) -> Int {
        return Calendar.current.dateComponents([.day], from: start, to: end).day!
    }
}
