//
//  Budget.swift
//  Demo
//
//  Created by Ben Vickers on 10/10/2016.
//  Copyright © 2016 Ben Vickers. All rights reserved.
//

import UIKit

class Budget: NSObject, NSCoding {
    // MARK: Properties
    
        var name: String
        var photo: UIImage?
    
    //MARK: Archiving Paths
    
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("budgets")
    
    
    //MARK: Types
        
        struct PropertyKey{
            static let nameKey = "name"
            static let photoKey = "photo"
        }
        
    // MARK: Initialization
        
        init?(name: String, photo: UIImage?) {
    
            // Initialize stored properties.
            self.name = name
            self.photo = photo
            
            super.init()

            // Initialization should fail if there is no name
            if name.isEmpty {
                return nil
            }
            
    }
    
    //MARK: NSCoding
    func encode(with aCoder: NSCoder){
        aCoder.encode(name, forKey: PropertyKey.nameKey)
        aCoder.encode(photo, forKey: PropertyKey.photoKey)
    }
    
    required convenience init?(coder aDecode: NSCoder){
        let name = aDecode.decodeObject(forKey: PropertyKey.nameKey) as! String
        
        //Because photo is an optional property of Budget, use conditional cast.
        let photo = aDecode.decodeObject(forKey: PropertyKey.photoKey) as? UIImage
        
        //Must call designated initialiser
        self.init(name: name, photo: photo)
    }
}
