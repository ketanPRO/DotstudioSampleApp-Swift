//
//  DSConfig.swift
//  DotstudioSampleApp
//
//  Created by Ketan Sakariya on 14/05/18.
//  Copyright © 2018 Dotstudioz. All rights reserved.
//

import Foundation
import DotstudioAPI

class DSConfig {

    public static var strGoogleAnalyticsKey: String? = nil
    public static var strRelicAppKey: String? = nil
    public static var strFlurryAPIKey: String? = nil
    
    class func setDebugMode(_ on: Bool) {
        SPLTConfig.setDebugMode(on)
    }
    class func setup() {
        // To enable debug mode. uncomment below method.
        DSConfig.setDebugMode(false)
        
        // Set company API key Below.
        SPLTRouter.API_KEY = "a12878949f4ea52703ab6a07c662b31895886cea"
        
        // Set Google Analytics Key
        DSConfig.strGoogleAnalyticsKey = nil
        
        // Set Relic App Key
        DSConfig.strRelicAppKey = nil
        
        // Set Flurry Key
        DSConfig.strFlurryAPIKey = nil
     
        self.initializeLibraries()
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



