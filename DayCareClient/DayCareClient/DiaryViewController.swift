//
//  ViewController.swift
//  DayCareClient
//
//  Created by Tayal, Rishabh on 3/28/16.
//  Copyright © 2016 Tayal, Rishabh. All rights reserved.
//

import UIKit
import Parse
import NYTPhotoViewer

class DiaryViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    var dataArray: [DCDiary] = []
    var refreshControl: UIRefreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Diary"
        
        refreshControl.addTarget(self, action: #selector(refreshTable), forControlEvents: .ValueChanged)
        self.tableView.addSubview(refreshControl)
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 80
        tableView.separatorStyle = .None
        
        tableView.registerNib(UINib(nibName: "DiaryTableViewCell", bundle: AppConstants.CommonBundle), forCellReuseIdentifier: "diaryCell")
        
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
        let cell = tableView.dequeueReusableCellWithIdentifier("diaryCell") as? DiaryTableViewCell
        
        let object = dataArray[indexPath.row]
        
        cell?.configure(object)
        
        return cell!
    }
}

extension DiaryViewController: UITableViewDelegate {
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let object = dataArray[indexPath.row]
        let file = object.photo
        file.getDataInBackgroundWithBlock { (data: NSData?, error: NSError?) in
            if let data = data {
                let photo = Photo(imageData: data, attributedCaptionTitle: NSAttributedString(string: object.caption, attributes: [NSForegroundColorAttributeName: UIColor.whiteColor()]))
                let photosViewController = NYTPhotosViewController(photos: [photo])
                self.presentViewController(photosViewController, animated: true, completion: nil)
            }
        }
    }
}