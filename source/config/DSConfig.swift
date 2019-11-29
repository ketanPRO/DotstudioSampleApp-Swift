//
//  DSConfig.swift
//  DotstudioSampleApp
//
//  Created by Ketan Sakariya on 14/05/18.
//  Copyright © 2018 Dotstudioz. All rights reserved.
//

import Foundation
import UIKit
import DotstudioPRO

class DSConfig {

    public static var strGoogleAnalyticsKey: String? = nil
    public static var strRelicAppKey: String? = nil
    public static var strFlurryAPIKey: String? = nil
    
    class func setDebugMode(_ on: Bool) {
        SPLTConfig.setDebugMode(on)
    }
//    class func setup() {
//        
////        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
////            if let window = appDelegate.window {
////                SPLTAppDelegate.shared.setMainWindow(window)
////            }
////        }
//        
//        SPLTConfig.infoDictionaryBundleMain = Bundle.main.infoDictionary
//        SPLTConfig.bundleIdentifierBundleMain = Bundle.main.bundleIdentifier
//        SPLTConfig.APPNAME = "SampleApp"
//        
//        // To enable debug mode. uncomment below method & pass true.
////        DSConfig.setDebugMode(true)
//        
//        // Set company API key Below.
//        SPLTRouter.API_KEY = ""
//        
//        // Set Google Analytics Key
//        DSConfig.strGoogleAnalyticsKey = nil
//        
//        // Set Relic App Key
//        DSConfig.strRelicAppKey = nil
//        
//        // Set Flurry Key
//        DSConfig.strFlurryAPIKey = nil
//     
//        self.initializeLibraries()
//    }
    
    class func setup(window: UIWindow?) {
            
    //        SPLTConfig.infoDictionaryBundleMain = Bundle.main.infoDictionary
    //        SPLTConfig.bundleIdentifierBundleMain = Bundle.main.bundleIdentifier
//        SPLTConfig.strIAPPrefix = Bundle.main.bundleIdentifier
    //        SPLTConfig.APPNAME = "Revry"
    //        SPLTConfig.strHeaderApplicationName = "revry"
    //        SPLTConfig.auth0FBconnectionName = "facebook-revry"
            
            // Set company API key Below.
    //        SPLTRouter.API_KEY = "a12878949f4ea52703ab6a07c662b31895886cea"
            
            // Set Google Analytics Key
            #if os(iOS)
                DSConfig.strGoogleAnalyticsKey = ""
            #elseif os(tvOS)
                DSConfig.strGoogleAnalyticsKey = ""
            #endif

            //SPLTAnalyticsUtility.sharedInstance.addAnalyticsUtility(SPLTGAAnalyticsUtility.sharedInstance)
          
            // set Facebook Analytics Keys
            //SPLTAnalyticsUtility.sharedInstance.addAnalyticsUtility(SPLTFBAnalyticsUtility.sharedInstance)
            
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
                print("No App Delegate found")
                return
            }
            guard let window = appDelegate.window else {
                print("No Window found")
                return
            }
            
            SPLTConfig.window = window
            //DPro API Key: c681a9f6a3b9d51502cc3978298feaccfa9f500b
            let dsProConfig: [String : Any] = ["apikey": "c681a9f6a3b9d51502cc3978298feaccfa9f500b",
                                               "APP_NAME": "sampleapp",
                                               "APP_ID": "",
                                               "APP_URL": ""
            ]
            do {
                try DSPRO.initializeWith(config: dsProConfig, completion: { (bValue) in
                    // Success
                    
                }) { (error) in
                    // Error
                    print(error.debugDescription)
                }
            } catch let error {
                print(error.localizedDescription)
            }
        }
    
    
    class func initializeLibraries() {
        
        // Initialize Fabric
//        Fabric.with([Crashlytics()])
        
        // Initialize Google Analytics
//        if strGoogleAnalyticsKey = DSConfig.strGoogleAnalyticsKey {
//            GAI.sharedInstance().tracker(withTrackingId: strGoogleAnalyticsKey)
//        }
        
        // Initialize Relic
//        if let strRelicAppKey = DSConfig.strRelicAppKey {
//            NewRelicAgent.start(withApplicationToken: strRelicAppKey)
//        }
        
        // Initialize Flurry
//        if let strFlurryAPIKey = DSConfig.strFlurryAPIKey {
//            Flurry.startSession(FLURRY_API_KEY)
//        }
    }
    
}



