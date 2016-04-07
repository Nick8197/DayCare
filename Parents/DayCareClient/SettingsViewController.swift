//
//  SettingsViewController.swift
//  DayCareClient
//
//  Created by Tayal, Rishabh on 4/5/16.
//  Copyright © 2016 Tayal, Rishabh. All rights reserved.
//

import UIKit
import Parse
import AFNetworking

class SettingsViewController: UIViewController {
    
    @IBOutlet var childImageView: UIImageView!
    @IBOutlet var childNameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Logout", style: .Plain, target: self, action: #selector(SettingsViewController.logoutTapped(_:)))
        
        let user = User.currentUser()
        user?.child.fetchIfNeededInBackgroundWithBlock({ (child: PFObject?, error: NSError?) in
            self.childImageView.setImageWithURL(NSURL(string: (user?.child.image)!)!)
            self.childNameLabel.text = user?.child.name
        })
    }
    
    func logoutTapped(sender: AnyObject) {
        User.logOutInBackgroundWithBlock { (error: NSError?) in
            if error == nil {
                let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                appDelegate.showLoginView()
            }
        }
    }
}
