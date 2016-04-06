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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let query = DCDiary.query()
        query?.includeKey("child")
        query?.findObjectsInBackgroundWithBlock({ (objects: [PFObject]?, error: NSError?) in
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
        
        return cell!
    }
}

extension DiaryViewController: UITableViewDelegate {
    
}