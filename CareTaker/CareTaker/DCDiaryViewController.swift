//
//  DCDiaryViewController.swift
//  CareTaker
//
//  Created by Tayal, Rishabh on 4/6/16.
//  Copyright © 2016 Tayal, Rishabh. All rights reserved.
//

import UIKit
import Parse

class DCDiaryViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    
    var dataArray: [DCDiary] = []
    var refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.navigationController?.navigationBar.translucent = false
        
        refreshControl.addTarget(self, action: #selector(loadQuery), forControlEvents: .ValueChanged)
        self.tableView.addSubview(refreshControl)
        
        loadQuery()
    }
    
    func loadQuery() {
        self.refreshControl.beginRefreshing()
        let query = DCDiary.query()
        //        query?.whereKey("child", containedIn: )
        query?.includeKey("child")
        query?.findObjectsInBackgroundWithBlock({ (objects: [PFObject]?, error: NSError?) in
            self.refreshControl.endRefreshing()
            if let objects = objects {
                self.dataArray = objects as! [DCDiary]
                self.tableView.reloadData()
            }
        })
    }
    
    @IBAction func newDiaryPhotoTapped(sender: AnyObject) {
        let newDiaryVC = self.storyboard?.instantiateViewControllerWithIdentifier("DCNewDiaryViewController") as! DCNewDiaryViewController
        self.presentViewController(UINavigationController(rootViewController: newDiaryVC), animated: true, completion: nil)
    }
}

extension DCDiaryViewController: UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell")
        
        let obj = dataArray[indexPath.row]
        cell?.textLabel?.text = obj.child.name
        
        return cell!
    }
}

extension DCDiaryViewController: UITableViewDelegate {
    
}