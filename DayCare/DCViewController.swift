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
    
    var dataArray: [PFObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        PFCloud.callFunctionInBackground("hello", withParameters: nil) { (result: AnyObject?, error: NSError?) in
//            print(result)
//        }

        let query = PFQuery(className: "Child")
        query.findObjectsInBackgroundWithBlock { (objects: [PFObject]?, error: NSError?) in
            self.dataArray = objects!
            self.collectionView.reloadData()
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
        
        cell.backgroundColor = .grayColor()
        if let url = child["image"] as? String {
            cell.imageView.setImageWithURL(NSURL(string: url)!)
        }
        cell.nameLabel.text = child["name"] as? String
        
        return cell
    }
}

extension DCViewController: UICollectionViewDelegate {
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        print("selected " + String(indexPath.row))
    }
}