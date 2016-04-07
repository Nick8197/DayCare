//
//  RoutineViewController.swift
//  DayCareClient
//
//  Created by Tayal, Rishabh on 4/5/16.
//  Copyright © 2016 Tayal, Rishabh. All rights reserved.
//

import UIKit

class RoutineViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    
    var dataArray: [AnyObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Routine"
        
        dataArray.append("a")
    }
    
    @IBAction func submitRoutineTapped(sender: AnyObject) {
        let submitReportVC = storyboard?.instantiateViewControllerWithIdentifier("SubmitRoutineViewController") as! SubmitRoutineViewController
        self.navigationController?.pushViewController(submitReportVC, animated: true)
    }
}

extension RoutineViewController: UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell")
        
        cell?.textLabel?.text = dataArray[indexPath.row] as? String
        
        return cell!
    }
}

extension RoutineViewController: UITableViewDelegate {
    
}