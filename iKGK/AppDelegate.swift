//
//  AppDelegate.swift
//  iKGK
//
//  Created by Matouš Hýbl on 17/04/15.
//  Copyright (c) 2015 KGK. All rights reserved.
//

import UIKit
import Classy
import Realm
import SnapKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        #if (arch(i386) || arch(x86_64)) && os(iOS)
            let absoluteFilePath = _CASAbsoluteFilePath(__FILE__, "stylesheet.cas")
            CASStyler.defaultStyler().watchFilePath = absoluteFilePath
            
            let realmTestingPath = _CASAbsoluteFilePath(__FILE__, "../realm-db/testing.realm")
            RLMRealm.setDefaultRealmPath(realmTestingPath)
        #endif
        
        var rootController: UIViewController = MainController()
        if(Preferences.id == 0) {
            rootController = LoadingController()
        } else {
            let navigationController = UINavigationController(rootViewController: rootController)
            navigationController.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
            rootController = navigationController
        }
        
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        // Override point for customization after application launch.
        window!.backgroundColor = UIColor.whiteColor()
        window!.makeKeyAndVisible()
        window!.rootViewController = rootController
        window!.tintColor = UIColor(red: 0.573, green: 0.573, blue: 0.573, alpha: 1)
        application.statusBarStyle = UIStatusBarStyle.LightContent
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

