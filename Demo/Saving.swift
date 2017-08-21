//
//  Savings.swift
//  My P&L
//
//  Created by Ben Vickers on 17/03/2017.
//  Copyright © 2017 Ben Vickers. All rights reserved.
//

import UIKit

import os.log

class Saving: NSObject, NSCoding {
    
    // MARK: Properties
    var savingname: String
    var savingamount: Double
    
    
    //MARK: Archiving Paths
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("savings")
    
    //MARK: Types
    struct PropertyKey {
        static let savingnameKey = "savingname"
        static let savingamountKey = "savingamount"
    }

    
    // MARK: Initialization
    
    init?(savingname: String, savingamount: Double) {
        
        // Initialize stored properties.
        self.savingname = savingname
        self.savingamount = Double(savingamount)
        
        super.init()
        
        // Initialization should fail if there is no name
        if savingname.isEmpty {
            return nil
        }
        
    }
    
    //MARK: NSCoding
    func encode(with aCoder: NSCoder){
        aCoder.encode(savingname, forKey: PropertyKey.savingnameKey)
        aCoder.encode(savingamount, forKey: PropertyKey.savingamountKey)
    }
    
    required convenience init?(coder aDecode: NSCoder){
        guard let savingname = aDecode.decodeObject(forKey: PropertyKey.savingnameKey) as? String
            else {
                os_log("Unable to decode the bank account name.", log: OSLog.default, type: .debug)
                return nil
        }
        
        // Because photo is an optional property of Meal, just use conditional cast.
        //  let photo = aDecode.decodeObject(forKey: PropertyKey.photo) as? UIImage
        
        guard let savingamount = aDecode.decodeDouble(forKey: PropertyKey.savingamountKey) as? Double
            else {
                os_log("Unable to decode the amount.", log: OSLog.default, type: .debug)
                return nil
        }
        
        
        //Must call designated initialiser
        self.init(savingname: savingname, savingamount: savingamount)
    }

    
}
