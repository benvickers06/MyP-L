//
//  SavingsDataModel.swift
//  My P&L
//
//  Created by Ben Vickers on 17/03/2017.
//  Copyright © 2017 Ben Vickers. All rights reserved.
//

import Foundation

import os.log

var SavingsDataModel = savingdata()

class savingdata{
    
    //Properties
    var savings = [Saving]()
    var savingstotal : Double = 0.0

    // Calculate savingstotal
    func calculateSavingsTotal() {
        savingstotal = 0
        for (element) in savings
        {
            savingstotal += element.savingamount
        }
    }
    
    //Saving savings
    func saveSavings(){
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(savings, toFile: Saving.ArchiveURL.path)
        if isSuccessfulSave
        {
            os_log("Savings successfully saved.", log: OSLog.default, type: .debug)
        }
        else if !isSuccessfulSave
        {
            print("Failed to save savings...")
            os_log("Failed to save savings...", log: OSLog.default, type: .debug)
        }
    }

    //Loading savings
    func loadSavings() -> [Saving]?{
        return NSKeyedUnarchiver.unarchiveObject(withFile: Saving.ArchiveURL.path) as? [Saving]
    }

    
    //Load the inital savings
    func GetInitialSavings(){
        if let savedSavings = loadSavings()
        {
            savings += savedSavings
        }
        else
        {
            //Load the sample data.
            //loadSampleBudgets()
        }
    }

    
}
