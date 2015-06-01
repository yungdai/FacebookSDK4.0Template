//
//  ViewController.swift
//  FacebookSDK4.0Template
//
//  Created by Yung Dai on 2015-06-01.
//  Copyright (c) 2015 Yung Dai. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var errorMessage: UILabel!
    let permissions = ["public_profile", "email", "user_friends"]
    

    @IBAction func facebookButton
        (sender: AnyObject) {
            self.errorMessage.alpha = 0
            if FBSDKAccessToken.currentAccessToken() != nil {
                //For debugging, when we want to ensure that facebook login always happens
                FBSDKLoginManager().logOut()
                //Otherwise do:
                return
            }
            FBSDKLoginManager().logInWithReadPermissions(self.permissions, handler: { (result:FBSDKLoginManagerLoginResult!, error:NSError!) -> Void in
                if error != nil {
                    //According to Facebook:
                    //Errors will rarely occur in the typical login flow because the login dialog
                    //presented by Facebook via single sign on will guide the users to resolve any errors.
                    FBSDKLoginManager().logOut()
                    println("log out user")
                    
                } else if result.isCancelled {
                    // Handle cancellations
                    FBSDKLoginManager().logOut()
                    self.errorMessage.alpha = 1
                    print("user cancelled login process")
                    
                } else {
                    // If you ask for multiple permissions at once, you
                    // should check if specific permissions missing
                    var allPermsGranted = true
                    
                    //result.grantedPermissions returns an array of _NSCFString pointers
                    let perms = result.grantedPermissions as NSSet
                    let grantedPermissions = perms.allObjects.map({$0})
                    for permission in self.permissions {
                        /*if !contains(grantedPermissions, permission) {
                        allPermsGranted = false
                        break
                        }*/
                        println("permission were granted ")
                    }
                    if allPermsGranted {
                        // Do work
                        let fbToken = result.token.tokenString
                        let fbUserID = result.token.userID
                        self.performSegueWithIdentifier("signUp", sender: self)
                        NSLog("Do work section")
                    }
                }
            })
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


