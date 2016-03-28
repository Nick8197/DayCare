//
//  ViewController.swift
//  DayCare
//
//  Created by Tayal, Rishabh on 3/26/16.
//  Copyright © 2016 Tayal, Rishabh. All rights reserved.
//

import UIKit
import Parse

class DCViewController: UIViewController {

    @IBOutlet var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        PFCloud.callFunctionInBackground("hello", withParameters: nil) { (result: AnyObject?, error: NSError?) in
            print(result)
        }
        
        let obj = PFObject(className: "classNp")
        obj["a"] = "b"
        obj.saveInBackground()
    }
}

extension DCViewController: UICollectionViewDataSource {
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath)
        
        cell.backgroundColor = .grayColor()
        
        return cell
    }
}

extension DCViewController: UICollectionViewDelegate {
    
}