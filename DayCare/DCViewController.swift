//
//  ViewController.swift
//  DayCare
//
//  Created by Tayal, Rishabh on 3/26/16.
//  Copyright © 2016 Tayal, Rishabh. All rights reserved.
//

import UIKit
import Parse
import AFNetworking

class DCViewController: UIViewController {
    
    @IBOutlet var collectionView: UICollectionView!
    
    var dataArray: [DCChild] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let classQuery = PFQuery(className: "Class")
        classQuery.whereKey("name", equalTo: "Infant1")
        classQuery.getFirstObjectInBackgroundWithBlock { (classObj: PFObject?, error: NSError?) in
            if let classObj = classObj as? DCClass {
                self.title = classObj.name
                
                let query = DCChild.query()!
                query.whereKey("class", equalTo: classObj)
                query.findObjectsInBackgroundWithBlock { (objects: [PFObject]?, error: NSError?) in
                    if let objects = objects as? [DCChild] {
                        self.dataArray = objects
                        self.collectionView.reloadData()
                    }
                }
            } else {
                print(error)
            }
        }
        collectionView.alwaysBounceVertical = true
    }
}

extension DCViewController: UICollectionViewDataSource {
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! DCChildCollectionViewCell
        
        let child = dataArray[indexPath.row]
        
        if let url = child.image {
            cell.imageView.setImageWithURL(NSURL(string: url)!)
        }
        cell.nameLabel.text = child.name
        
        return cell
    }
}

extension DCViewController: UICollectionViewDelegate {
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        print("selected " + String(indexPath.row))
        
        let dailyReportVC = storyboard?.instantiateViewControllerWithIdentifier("DCDailyReportViewController") as! DCDailyReportViewController
        dailyReportVC.child = dataArray[indexPath.row]
        let navC = UINavigationController(rootViewController: dailyReportVC)
        navC.modalPresentationStyle = UIModalPresentationStyle.FormSheet
        self.presentViewController(navC, animated: true, completion: nil)
    }
}