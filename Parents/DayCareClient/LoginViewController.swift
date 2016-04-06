//
//  LoginViewController.swift
//  DayCareClient
//
//  Created by Tayal, Rishabh on 4/5/16.
//  Copyright © 2016 Tayal, Rishabh. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    @IBOutlet var usernameTextfield: UITextField!
    @IBOutlet var passwordTextfield: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func loginTapped(sender: AnyObject) {
        PFUser.logInWithUsernameInBackground(usernameTextfield.text!, password: passwordTextfield.text!) { (user: PFUser?, error: NSError?) in
            if let _ = user {
                let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                appDelegate.showTabView()
            }
        }
    }
}
