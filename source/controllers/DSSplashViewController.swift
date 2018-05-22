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
    
    @IBOutlet weak open override var imageView: UIImageView? {
        get {
            return super.imageView
        }
        set {
            super.imageView = newValue
        }
    }

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
        SPLTTokenAPI().getToken { (accessToken) in
            print(accessToken)
        }
    }
    
    override open func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    override open func checkSessionAndLogin() {
//        super.checkSessionAndLogin()
//        self.loadMainViewController()
//    }
    override open func loadMainViewController() {
        #if os(iOS)
            let spltHomeTabBarController = self.getViewControllerFromStoryboardName("tabbar", strViewControllerIdentifier: "SPLTHomeTabBarController")
            if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
                appDelegate.window?.rootViewController = spltHomeTabBarController //homeTabBarController
            }
        #elseif os(tvOS)
        let spltBaseNavigationViewController = self.getViewControllerFromStoryboardName("tabbar", strViewControllerIdentifier: "SPLTBaseNavigationViewController")
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            appDelegate.window?.rootViewController = spltBaseNavigationViewController //homeTabBarController
        }
        #endif
    }
    
}




