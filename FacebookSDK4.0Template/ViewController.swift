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
            
            PFFacebookUtils.logInInBackgroundWithReadPermissions(permissions as [AnyObject]) {
                (user: PFUser?, error: NSError?) -> Void in
                
                if error != nil
                {
                    return;
                }
                if let parseUser = user {
                    if parseUser.isNew {
                        println("User signed up and logged in through Facebook!")
                        let graphRequest : FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "/me?fields=first_name,gender,email,name,picture.width(300).height(300)", parameters: nil)
                        graphRequest.startWithCompletionHandler({
                            (connection, result, error) -> Void in
                            if (error != nil)
                            {
                                // display the error message
                                println("Error: \(error)")
                            } else {
                                // parsing the facebook data from the graph API and saving it to parse
                                // save the facebook name and email data to parseUser
                                parseUser["name"] = result["name"]
                                parseUser["email"] = result["email"]
                                parseUser["first_name"] = result["first_name"]
                                parseUser["gender"] = result["gender"]
                                
                                // test to make sure that the moreAboutMe column is empty before it's init
                                if parseUser["moreAboutMe"] != nil {
                                    println("didn't erase moreAboutme")
                                } else {
                                    parseUser["moreAboutMe"] = ""
                                    println("moreAboutMe reset")
                                }
                                
                                // sending the data to NSUserDefaults as well
                                
                                // sending the facebook picture to parse as a string
                                if let pictureResult = result["picture"] as? NSDictionary,
                                    pictureData = pictureResult["data"] as? NSDictionary,
                                    picture = pictureData["url"] as? String {
                                        parseUser["photo"] = picture
                                        
                                }
                                
                                // save the user's location to parse before you save the information
                                PFGeoPoint.geoPointForCurrentLocationInBackground { (geoPoint:PFGeoPoint?, error:NSError?) -> Void in
                                    if let user = PFUser.currentUser() {
                                        user["currentLocation"] = geoPoint
                                        user.saveInBackground()
                                    }
                                }
                                parseUser.saveInBackground()
                                println("Parse User Saved")
                                self.performSegueWithIdentifier("signUp", sender: nil)
                            }
                        })
                    } else {
                        println("User logged in through Facebook WITH PERMISSIONS!")
                        self.performSegueWithIdentifier("mainPage", sender: nil)
                    }
                }
            }
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


