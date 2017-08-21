//
//  PasscodeViewController.swift
//  My P&L
//
//  Created by Ben Vickers on 31/03/2017.
//  Copyright © 2017 Ben Vickers. All rights reserved.
//

import UIKit
import LocalAuthentication

class PasscodeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        print("Loading PasscodeViewController")

        let authenticationObject = LAContext()
        var authenticationError:NSError?
        
        //Can the device use touch ID?
        authenticationObject.canEvaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, error: &authenticationError)

        if authenticationError != nil
        {
            //There is an error: authentication not available in this version of iOS
            print("Authentication not available on this version of iOS")
        }
        else{
            //Authentication is available - proceed as we were
            authenticationObject.evaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, localizedReason: "Access your P&L with a touch of your finger", reply: { (complete:Bool!, error:Error?) -> Void in
                
                if error != nil{
                    // There is an error - user likely pressed cancel.
                    print(error?.localizedDescription as Any)
                }
                else{
                    //There is no error - the authentication completed successfully
                    if complete == true
                    {
                        OperationQueue.main.addOperation({() -> Void in
                        print("Authentication Successful!")
                        self.navigateToHomeViewVC()
                        })
                    }
                    else{
                        //User was not the correct user - cancel
                        print("Authentication Failed!")
                    }
                }
            })
            
        }
    }
    
        func navigateToHomeViewVC() {
            if let loggedInVC = storyboard?.instantiateViewController(withIdentifier: "LoggedInVC")
            {
                self.present(loggedInVC, animated: true)
            }
    }
}
