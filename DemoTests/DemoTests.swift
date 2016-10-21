//
//  DemoTests.swift
//  DemoTests
//
//  Created by Ben Vickers on 09/10/2016.
//  Copyright © 2016 Ben Vickers. All rights reserved.
//

import XCTest
@testable import Demo

class DemoTests: XCTestCase {
    
    //Mark: Budget Tests
    
    //Tests to confirm that the budget initialiser returns when no name is provided
    func testbudgetInitialisation(){
        
        //Success case
        let potentialItem = Budget(name: "Newest budget", photo: nil)
        XCTAssertNotNil(potentialItem)
        
        //Failure case
        let noName = Budget(name: "", photo: nil)
        XCTAssertNil(noName, "Empty name is invalid")
        
    }
    
}
