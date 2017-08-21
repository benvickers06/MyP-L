//
//  PaydayDataModel.swift
//  My P&L
//
//  Created by Ben Vickers on 21/03/2017.
//  Copyright © 2017 Ben Vickers. All rights reserved.
//

import Foundation

import os.log

var PaydayDataModel = pdDataModel()

class pdDataModel {
    
    //Properties
    var paydays = [Payday]()
    var payday : String = ""

    //Saving the payday date given
    func savePayday(){
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(payday, toFile: Payday.ArchiveURL.path)
        if isSuccessfulSave{
            os_log("Paydays successfully saved.", log: OSLog.default, type: .debug)
        }else if !isSuccessfulSave {
            print("Failed to save paydays...")
            os_log("Failed to save paydays...", log: OSLog.default, type: .debug)
        }
        
    }
    
    //Loading the payday date given
    func loadPayday() -> [Payday]?{
        return NSKeyedUnarchiver.unarchiveObject(withFile: Payday.ArchiveURL.path) as? [Payday]
    }
    
}
