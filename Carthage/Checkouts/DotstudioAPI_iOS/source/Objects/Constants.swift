//
//  Constants.swift
//  DotstudioPRO
//
//  Created by Ketan Sakariya on 22/08/16.
//  Copyright © 2016 ___DotStudioz___. All rights reserved.
//

import Foundation


struct SPLTConstants {
    static let SPLTCompanyData_DidUpdateCategories = "SPLTCompanyData_DidUpdateCategories_"
    static let SPLTCategory_DidUpdateCategoryChannels = "SPLTCategory_DidUpdateCategoryChannels_"
//    static let SPLTCompanyData_DidUpdateCategories = "SPLTCompanyData_DidUpdateCategories"
}

extension Notification.Name {
    static let SPLT_LOGIN_COMPLETED = NSNotification.Name("SPLT_LOGIN_COMPLETED")
    static let SPLT_LOGOUT_COMPLETED = NSNotification.Name("SPLT_LOGOUT_COMPLETED")
}

