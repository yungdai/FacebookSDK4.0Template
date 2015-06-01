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
    
    @IBAction func signUpButton(sender: AnyObject) {

        
    }
    @IBOutlet weak var profileImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var FBSession = FBSDKAccessToken.currentAccessToken()
        var accessToken = FBSession?.tokenString
        let url = NSURL(string:"https://graph.facebook.com/me/picture?type=large&return_ssl_resources=1&access_token="+accessToken!)
        let urlRequest = NSURLRequest(URL: url!)
        NSURLConnection.sendAsynchronousRequest(urlRequest, queue: NSOperationQueue.mainQueue()) { (response, data, error) -> Void in
            // print(data )
            var dataObject = data
            // convert the data and pass to image
            let image = UIImage(data: data)
            self.profileImage.image = image
            self.profileImage.layer.cornerRadius = self.profileImage.frame.size.width / 2;
            self.profileImage.clipsToBounds = true
            // save data to parse
            var FBReqest:FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "me", parameters: nil)
            FBReqest.startWithCompletionHandler({ (connection, result, error) -> Void in
                if !(error != nil) {
                    println("\(result)")
                    self.user!["name"] = result["name"] as! String
                    self.user!["gender"] = result["gender"] as! String
                    self.user!["email"] = result["email"] as! String
                    print(result["email"])
                    self.user!.save()
                }
            })
        }

    }

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
