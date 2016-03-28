//
//  AppDelegate.swift
//  DayCare
//
//  Created by Tayal, Rishabh on 3/26/16.
//  Copyright © 2016 Tayal, Rishabh. All rights reserved.
//

import UIKit
import Parse

@UIApplicationMain
class DCAppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {

        DCClass.registerSubclass()
        DCChild.registerSubclass()
        
        let config = ParseClientConfiguration {
            $0.applicationId = "myAppId"
            $0.clientKey = ""
            $0.server = "https://arcane-fortress-10529.herokuapp.com/parse"
        }
        Parse.initializeWithConfiguration(config)
        
        return true
    }
}

