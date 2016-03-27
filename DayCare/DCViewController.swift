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