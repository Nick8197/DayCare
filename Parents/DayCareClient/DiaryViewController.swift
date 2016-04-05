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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        PFCloud.callFunctionInBackground("notification", withParameters: nil) { (result: AnyObject?, error: NSError?) in
//            completion(result: result, error: error)
            print(error)
        }

    }
}

