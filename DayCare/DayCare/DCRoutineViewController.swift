//
//  RoutineViewController.swift
//  DayCareClient
//
//  Created by Tayal, Rishabh on 4/5/16.
//  Copyright © 2016 Tayal, Rishabh. All rights reserved.
//

import UIKit
import Parse
import DZNEmptyDataSet

class DCRoutineViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    
    var child: DCChild!
    var dataArray: [DCRoutine] = []
    var refreshControl: UIRefreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Routine"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Submit Routine", style: .Plain, target: self, action: #selector(submitRoutineTapped(_:)))
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .Plain, target: self, action: #selector(cancelTapped(_:)))
        
        refreshControl.addTarget(self, action: #selector(loadRoutineObjects), forControlEvents: .ValueChanged)
        tableView.addSubview(refreshControl)
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 60
        self.tableView.registerNib(UINib(nibName: "RoutineTableViewCell", bundle: AppConstants.CommonBundle), forCellReuseIdentifier: "routineCell")
        self.tableView.tableFooterView = UIView()
        
        self.tableView.emptyDataSetSource = self
        self.tableView.emptyDataSetDelegate = self
        
        loadRoutineObjects()
    }
    
    func cancelTapped(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    func loadRoutineObjects() {
        refreshControl.beginRefreshing()
        let query = DCRoutine.query()
        query?.whereKey("child", equalTo: child)
        query?.orderByDescending("createdAt")
        query?.findObjectsInBackgroundWithBlock({ (objects: [PFObject]?, error: NSError?) in
            self.refreshControl.endRefreshing()
            if let objects = objects {
                self.dataArray = objects as! [DCRoutine]
                self.tableView.reloadData()
            }
        })
    }
    
    @IBAction func submitRoutineTapped(sender: AnyObject?) {
        let submitReportVC = storyboard?.instantiateViewControllerWithIdentifier("DCSubmitRoutineViewController") as! DCSubmitRoutineViewController
        submitReportVC.child = child
        self.navigationController?.pushViewController(submitReportVC, animated: true)
    }
}

extension DCRoutineViewController: UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("routineCell") as! RoutineTableViewCell
        
        let routine = dataArray[indexPath.row]
        cell.configure(routine)
        
        return cell
    }
}

extension DCRoutineViewController: UITableViewDelegate {
    
}

extension DCRoutineViewController: DZNEmptyDataSetSource, DZNEmptyDataSetDelegate {
    func titleForEmptyDataSet(scrollView: UIScrollView!) -> NSAttributedString! {
        return NSAttributedString(string: "No routine submitted")
    }
    
    func buttonTitleForEmptyDataSet(scrollView: UIScrollView!, forState state: UIControlState) -> NSAttributedString! {
        return NSAttributedString(string: "Submit Routine", attributes: [NSForegroundColorAttributeName: UIColor.blueColor()])
    }
    
    func emptyDataSetDidTapButton(scrollView: UIScrollView!) {
        submitRoutineTapped(nil)
    }
}
