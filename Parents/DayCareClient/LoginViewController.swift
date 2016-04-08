//
//  LoginViewController.swift
//  DayCareClient
//
//  Created by Tayal, Rishabh on 4/5/16.
//  Copyright © 2016 Tayal, Rishabh. All rights reserved.
//

import UIKit
import Parse
import MBProgressHUD

class LoginViewController: UIViewController {
    
    @IBOutlet var usernameTextfield: UITextField!
    @IBOutlet var passwordTextfield: UITextField!
    
    @IBOutlet var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginButton.roundView(5)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tappedOnView(_:)))
        self.view.addGestureRecognizer(tapGesture)
    }
    
    func tappedOnView(sender: AnyObject) {
        self.view.endEditing(true)
    }
    
    @IBAction func loginTapped(sender: AnyObject) {
        self.view.endEditing(true)
        MBProgressHUD.showHUDAddedTo(view, animated: true)
        ClientUser.logInWithUsernameInBackground(usernameTextfield.text!, password: passwordTextfield.text!) { (user: PFUser?, error: NSError?) in
            MBProgressHUD.hideHUDForView(self.view, animated: true)
            if let user = user as? ClientUser {
                if user.userType == UserType.Parent.rawValue {
                    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                    appDelegate.showTabView()
                } else {
                    ClientUser.logOut()
                    let alert = UIAlertController(title: "Could not login", message: "Please check the username/password.", preferredStyle: .Alert)
                    alert.addAction(UIAlertAction(title: "Dismiss", style: .Cancel, handler: nil))
                    self.presentViewController(alert, animated: true, completion: nil)
                }
            } else {
                let alert = UIAlertController(title: "Could not login", message: error?.localizedDescription, preferredStyle: .Alert)
                alert.addAction(UIAlertAction(title: "Dismiss", style: .Cancel, handler: nil))
                self.presentViewController(alert, animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func forgotTapped(sender: AnyObject) {
        print("forgot tapped")
//        let alert = UIAlertController(title: "Enter email", message: "", preferredStyle: .Alert)
//        alert.addTextFieldWithConfigurationHandler(nil)
//        alert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { (action: UIAlertAction) in
//            let textfield = alert.textFields?.first
//            ClientUser.requestPasswordResetForEmailInBackground((textfield?.text)!, block: { (success: Bool, error: NSError?) in
//                print(error)
//            })
//        }))
//        alert.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: nil))
//        self.presentViewController(alert, animated: true, completion: nil)
    }
}
