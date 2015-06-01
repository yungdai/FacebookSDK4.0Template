//
//  MainAppViewController.swift
//  FacebookSDK4.0Template
//
//  Created by Yung Dai on 2015-06-01.
//  Copyright (c) 2015 Yung Dai. All rights reserved.
//

import UIKit

class MainAppViewController: UIViewController {

    @IBAction func logoutButtonPressed(sender: AnyObject) {
        
        PFUser.logOut()
        println("Parse User Logged Out")
        self.performSegueWithIdentifier("goToLogin", sender: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
