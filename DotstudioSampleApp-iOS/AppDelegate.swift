//
//  AppDelegate.swift
//  DotstudioSampleApp-Swift
//
//  Created by primesoft on 08/05/18.
//  Copyright © 2018 Dotstudioz. All rights reserved.
//

import UIKit
import DotstudioAPI

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        SPLTRouter.API_KEY = "cf72565d2a62067e4e33e16d9e81e366ad08dd54" // wonder science
        SPLTRouter.API_KEY = "84b1403831a8f9ea1763d40d187246765417e8c5" //114194a80a92fd5c3048f4c95cc32cc882e22ef6" // Decentric Network

//        if let appDelegate: AppDelegate = UIApplication.shared.delegate as? AppDelegate {
//            let splashStoryboard = UIStoryboard(name: "splash", bundle: nil)
//            if let dsSplashViewController = splashStoryboard.instantiateViewController(withIdentifier: "DSSplashViewController") as? DSSplashViewController {
//                appDelegate.window?.rootViewController = dsSplashViewController
//            }
//        }
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

