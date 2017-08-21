//
//  Expenditures.swift
//  My P&L
//
//  Created by Ben Vickers on 06/04/2017.
//  Copyright © 2017 Ben Vickers. All rights reserved.
//

import UIKit

import os.log

class Expense: NSObject, NSCoding {
    
    // MARK: Properties
    var expensename: String
    //  var photo: UIImage?
    var expenseamount: Double
    var expensedate = String()
    
    
    //MARK: Archiving Paths
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("expense")
    
    //MARK: Types
    struct PropertyKey {
        static let expensenameKey = "expensename"
        //  static let photo = "photo"
        static let expenseamountKey = "expenseamount"
        static let expensedateKey = "expensedate"
    }
    
    
    // MARK: Initialization
    
    init?(expensename: String, /*photo: UIImage?,*/expenseamount: Double, expensedate: String) {
        
        // Initialize stored properties.
        self.expensename = expensename
        //self.photo = photo
        self.expenseamount = Double(expenseamount)
        self.expensedate = expensedate
        
        super.init()
        
        // Initialization should fail if there is no name
        if expensename.isEmpty {
            return nil
        }
        
    }
    
    //MARK: NSCoding
    func encode(with aCoder: NSCoder){
        aCoder.encode(expensename, forKey: PropertyKey.expensenameKey)
        aCoder.encode(expenseamount, forKey: PropertyKey.expenseamountKey)
        aCoder.encode(expensedate, forKey: PropertyKey.expensedateKey)
    }
    
    required convenience init?(coder aDecode: NSCoder){
        guard let expensename = aDecode.decodeObject(forKey: PropertyKey.expensenameKey) as? String
            else {
                os_log("Unable to decode the bank account name.", log: OSLog.default, type: .debug)
                return nil
        }
        
        // Because photo is an optional property of Meal, just use conditional cast.
        //  let photo = aDecode.decodeObject(forKey: PropertyKey.photo) as? UIImage
        
        guard let expenseamount = aDecode.decodeDouble(forKey: PropertyKey.expenseamountKey) as? Double
            else {
                os_log("Unable to decode the amount.", log: OSLog.default, type: .debug)
                return nil
        }
        
        guard let expensedate = aDecode.decodeObject(forKey: PropertyKey.expensedateKey) as? String
            else {
                os_log("Unable to decode the date", log: OSLog.default, type: .debug)
                return nil
        }
        
        
        //Must call designated initialiser
        self.init(expensename: expensename, /*photo: photo,*/ expenseamount: expenseamount, expensedate: expensedate)
    }
    
}

