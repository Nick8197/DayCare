//
//  AppDelegate.swift
//  DayCare
//
//  Created by Tayal, Rishabh on 3/26/16.
//  Copyright © 2016 Tayal, Rishabh. All rights reserved.
//

import UIKit
import Parse
import Fabric
import Crashlytics

@UIApplicationMain
class DCAppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {

        Fabric.with([Crashlytics.self])

        DCClass.registerSubclass()
        DCChild.registerSubclass()
        DCDiary.registerSubclass()
        
        let config = ParseClientConfiguration {
            $0.applicationId = "myAppId"
            $0.clientKey = ""
            $0.server = "https://arcane-fortress-10529.herokuapp.com/parse"
        }
        Parse.initializeWithConfiguration(config)
        
        return true
    }
}

