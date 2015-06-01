//
//  SignUpViewController.swift
//  FacebookSDK4.0Template
//
//  Created by Yung Dai on 2015-06-01.
//  Copyright (c) 2015 Yung Dai. All rights reserved.
//

import UIKit
import Parse

class SignUpViewController: UIViewController {

    
    var user = PFUser.currentUser()
    let permissions = ["public_profile", "email", "user_friends"]
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var putSomethingHere: UITextField!
    
    @IBAction func signUpButton(sender: AnyObject) {
        
        if let user = PFUser.currentUser() {
            user["somethingHere"] = putSomethingHere.text
            user.saveInBackground()
        }
        
        // remember to do a PFUser
        
        self.performSegueWithIdentifier("goToMainApp", sender: nil)
                
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let currentUser = self.user,
            let urlString = currentUser["photo"] as? String {
                
                
                // parse the photo URL into data for the UIImageView
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), { () -> Void in
                    let data = NSData(contentsOfURL: NSURL(string: urlString)!)
                    dispatch_sync(dispatch_get_main_queue(), { () -> Void in
                        self.profileImage.image = UIImage(data: data!)
                    })
                })
        }
    }
    

        
        
        // create extra boxes for extra information about your user if you like in this storyboard, then add them into this view controller to same the

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
