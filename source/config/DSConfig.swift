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
    
    class func setup() {
        SPLTRouter.API_KEY = ""
        DSConfig.strGoogleAnalyticsKey = nil
    }
    
}



