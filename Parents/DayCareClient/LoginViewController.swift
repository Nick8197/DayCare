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
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tappedOnView(_:)))
        self.view.addGestureRecognizer(tapGesture)
    }
    
    func tappedOnView(sender: AnyObject) {
        self.view.endEditing(true)
    }
    
    @IBAction func loginTapped(sender: AnyObject) {
        self.view.endEditing(true)
        User.logInWithUsernameInBackground(usernameTextfield.text!, password: passwordTextfield.text!) { (user: PFUser?, error: NSError?) in
            if let _ = user {
                let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                appDelegate.showTabView()
            }
        }
    }
    
    @IBAction func forgotTapped(sender: AnyObject) {
        print("forgot tapped")
    }
}
