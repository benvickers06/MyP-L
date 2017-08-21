//
//  Budget.swift
//  Demo
//
//  Created by Ben Vickers on 10/10/2016.
//  Copyright © 2016 Ben Vickers. All rights reserved.
//

import UIKit

import os.log

class Budget: NSObject, NSCoding {
   
    // MARK: Properties
        var name: String
    //  var photo: UIImage?
        var amount: Double

    
    //MARK: Archiving Paths
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("budgets")
    
    //MARK: Types
        struct PropertyKey {
            static let nameKey = "name"
        //  static let photo = "photo"
            static let amountKey = "amount"
        }
    
       
    // MARK: Initialization
        
    init?(name: String, /*photo: UIImage?,*/amount: Double) {
    
            // Initialize stored properties.
            self.name = name
          //self.photo = photo
            self.amount = Double(amount)
            
            super.init()

            // Initialization should fail if there is no name
            if name.isEmpty {
                return nil
            }
        
    }
    
    //MARK: NSCoding
    func encode(with aCoder: NSCoder){
        aCoder.encode(name, forKey: PropertyKey.nameKey)
        aCoder.encode(amount, forKey: PropertyKey.amountKey)
    }
    
    required convenience init?(coder aDecode: NSCoder){
      guard let name = aDecode.decodeObject(forKey: PropertyKey.nameKey) as? String
        else {
            os_log("Unable to decode the bank account name.", log: OSLog.default, type: .debug)
            return nil
        }
        
        // Because photo is an optional property of Meal, just use conditional cast.
      //  let photo = aDecode.decodeObject(forKey: PropertyKey.photo) as? UIImage
        
        guard let amount = aDecode.decodeDouble(forKey: PropertyKey.amountKey) as? Double
            else {
                os_log("Unable to decode the amount.", log: OSLog.default, type: .debug)
                return nil
        }
        
        
        //Must call designated initialiser
       self.init(name: name, /*photo: photo,*/ amount: amount)
    }
    
}
