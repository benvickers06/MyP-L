//
//  Payday.swift
//  My P&L
//
//  Created by Ben Vickers on 21/03/2017.
//  Copyright © 2017 Ben Vickers. All rights reserved.
//

import UIKit

import os.log

class Payday: NSObject, NSCoding {
    
    // MARK: Properties
    var date = String()
    
    //MARK: Archiving Paths
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("paydays")
    
    //MARK: Types
    struct PropertyKey {
        static let dateKey = "date"
            }
    
    
    // MARK: Initialization
    
    init?(date: String) {
        
        // Initialize stored properties.
        self.date = date
       
        
        super.init()
        
        // Initialization should fail if there is no name
        if date.isEmpty {
            return nil
        }
        
    }
    
    //MARK: NSCoding
    func encode(with aCoder: NSCoder){
        aCoder.encode(date, forKey: PropertyKey.dateKey)
    }
    
    required convenience init?(coder aDecode: NSCoder){
        guard let date = aDecode.decodeObject(forKey: PropertyKey.dateKey) as? String
            else {
                os_log("Unable to decode the paydate.", log: OSLog.default, type: .debug)
                return nil
        }
        
        //Must call designated initialiser
        self.init(date: date)
    }
    
}
