//
//  DCDiaryViewController.swift
//  CareTaker
//
//  Created by Tayal, Rishabh on 4/6/16.
//  Copyright © 2016 Tayal, Rishabh. All rights reserved.
//

import UIKit
import Parse
import NYTPhotoViewer

class DCDiaryViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    @IBOutlet var postPhotoButton: UIButton!
    
    var dataArray: [DCDiary] = []
    var refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.navigationController?.navigationBar.translucent = false
        
        refreshControl.addTarget(self, action: #selector(loadQuery), forControlEvents: .ValueChanged)
        self.tableView.addSubview(refreshControl)
        self.tableView.separatorStyle = .None
        self.tableView.estimatedRowHeight = 80
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.registerNib(UINib(nibName: "DiaryTableViewCell", bundle: AppConstants.CommonBundle), forCellReuseIdentifier: "diaryCell")
    
        postPhotoButton.roundView(4)
        
        loadQuery()
    }
    
    func loadQuery() {
        self.refreshControl.beginRefreshing()
        let query = DCDiary.query()
        //        query?.whereKey("child", containedIn: )
        query?.includeKey("child")
        query?.orderByDescending("createdAt")
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
        let cell = tableView.dequeueReusableCellWithIdentifier("diaryCell") as! DiaryTableViewCell
        
        let obj = dataArray[indexPath.row]
        cell.configure(obj)
        
        return cell
    }
}

extension DCDiaryViewController: UITableViewDelegate {
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let object = dataArray[indexPath.row]
        let file = object.photo
        file.getDataInBackgroundWithBlock { (data: NSData?, error: NSError?) in
            if let data = data {
                let photo = Photo(imageData: data, attributedCaptionTitle: nil)
                let photosViewController = NYTPhotosViewController(photos: [photo])
                self.presentViewController(photosViewController, animated: true, completion: nil)
            }
        }
    }
}