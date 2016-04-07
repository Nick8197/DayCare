//
//  ViewController.swift
//  DayCareClient
//
//  Created by Tayal, Rishabh on 3/28/16.
//  Copyright © 2016 Tayal, Rishabh. All rights reserved.
//

import UIKit
import Parse

class DiaryViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    var dataArray: [DCDiary] = []
    var refreshControl: UIRefreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Diary"
        
        refreshControl.addTarget(self, action: #selector(refreshTable), forControlEvents: .ValueChanged)
        self.tableView.addSubview(refreshControl)
        
        refreshTable()
    }
    
    func refreshTable() {
        self.refreshControl.beginRefreshing()
        let query = DCDiary.query()
        query?.includeKey("child")
        //        query?.whereKey("child", equalTo: (User.currentUser()?.child)!)
        query?.orderByDescending("createdAt")
        query?.findObjectsInBackgroundWithBlock({ (objects: [PFObject]?, error: NSError?) in
            self.refreshControl.endRefreshing()
            if let objects = objects as? [DCDiary] {
                self.dataArray = objects
                self.tableView.reloadData()
            }
        })
    }
}

extension DiaryViewController: UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell")
        
        let object = dataArray[indexPath.row]
        cell?.textLabel?.text = object.child.name
        cell?.detailTextLabel?.text = object.diaparing.description
        
        let file = object.photo
        file.getDataInBackgroundWithBlock { (imageData: NSData?, error: NSError?) in
            if let imageData = imageData {
                cell?.imageView?.image = UIImage(data: imageData)
            }
        }
        
        return cell!
    }
}

extension DiaryViewController: UITableViewDelegate {
    
}