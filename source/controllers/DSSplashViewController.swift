//
//  DSSplashViewController.swift
//  DotstudioSampleApp
//
//  Created by Ketan Sakariya on 09/05/18.
//  Copyright © 2018 Dotstudioz. All rights reserved.
//

import Foundation
import DotstudioUI
import DotstudioAPI
import UIKit

@IBDesignable
open class DSSplashViewController: SPLTSplashViewController {
    

//    @IBInspectable override open var isVideoSplash: Bool {
//        get {
//            return super.isVideoSplash
//        }
//        set {
//            super.isVideoSplash = newValue
//        }
//    }
//    
//    @IBInspectable override open var autoTimeOutDuration: Double {
//        get {
//            return super.autoTimeOutDuration
//        }
//        set {
//            super.autoTimeOutDuration = newValue
//        }
//    }
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        SPLTRouter.API_KEY = "176908bf2a39eef53edf72b60e99e339da45a9ca"
        SPLTTokenAPI().getToken { (accessToken) in
            print(accessToken)
        }
    }
    
    override open func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override open func checkSessionAndLogin() {
        super.checkSessionAndLogin()
        self.loadMainViewController()
    }
    override open func loadMainViewController() {
        let spltHomeTabBarController = self.getViewControllerFromStoryboardName("tabbar", strViewControllerIdentifier: "SPLTHomeTabBarController")
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            appDelegate.window?.rootViewController = spltHomeTabBarController //homeTabBarController
        }
    }
    
}




