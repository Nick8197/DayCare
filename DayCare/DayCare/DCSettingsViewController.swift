//
//  DCSettingsViewController.swift
//  DayCare
//
//  Created by Tayal, Rishabh on 3/27/16.
//  Copyright © 2016 Tayal, Rishabh. All rights reserved.
//

import UIKit

class DCSettingsViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Logout", style: .Plain, target: self, action: #selector(logoutTapped(_:)))
    }
    
    func logoutTapped(sender: AnyObject) {
        BaseUser.logOutInBackgroundWithBlock { (error: NSError?) in
            if error == nil {
                let appDelegate = UIApplication.sharedApplication().delegate as! DCAppDelegate
                appDelegate.showLoginView()
            }
        }
    }
}

extension DCSettingsViewController: UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell")
        cell?.textLabel?.text = "Add a Child"
        return cell!
    }
}

extension DCSettingsViewController: UITableViewDelegate {
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
}