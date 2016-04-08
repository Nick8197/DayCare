//
//  AppDelegate.swift
//  DayCareClient
//
//  Created by Tayal, Rishabh on 3/28/16.
//  Copyright © 2016 Tayal, Rishabh. All rights reserved.
//

import UIKit
import Parse
import Fabric
import Crashlytics

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {

        Fabric.with([Crashlytics.self])

        DCDiary.registerSubclass()
        DCChild.registerSubclass()
        ClientUser.registerSubclass()
        DCRoutine.registerSubclass()
        
        let config = ParseClientConfiguration {
            $0.applicationId = "myAppId"
            $0.clientKey = ""
            $0.server = "https://arcane-fortress-10529.herokuapp.com/parse"
        }
        Parse.initializeWithConfiguration(config)
 
        if ClientUser.currentUser() != nil {
            showTabView()
        } else {
            showLoginView()
        }
        
        registerForRemoteNotifications()
        
        return true
    }
    
    func showLoginView() {
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        
        let loginVC = LoginViewController(nibName: "LoginViewController", bundle: nil)
        
        self.window?.rootViewController = loginVC
        self.window?.makeKeyAndVisible()
    }
    
    func showTabView() {
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        
        let tabVC = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()
        self.window?.rootViewController = tabVC
        self.window?.makeKeyAndVisible()
    }
    
    func registerForRemoteNotifications() {
        let types: UIUserNotificationType = [.Alert, UIUserNotificationType.Badge, .Sound]
        let settings = UIUserNotificationSettings(forTypes: types, categories: nil)
        
        UIApplication.sharedApplication().registerUserNotificationSettings(settings)
        UIApplication.sharedApplication().registerForRemoteNotifications()
    }
    
    func application(application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData) {
        print("register")
        let installation = PFInstallation.currentInstallation()
        installation.setDeviceTokenFromData(deviceToken)
        installation.channels = ["channel"]
        installation.saveEventually()
    }
    
    func application(application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: NSError) {
        print("Fail")
    }
}