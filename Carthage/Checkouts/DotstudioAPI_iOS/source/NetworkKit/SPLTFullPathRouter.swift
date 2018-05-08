//
//  SPLTImageRouter.swift
//  DotstudioPRO
//
//  Created by Ketan Sakariya on 21/11/16.
//  Copyright © 2016 ___DotStudioz___. All rights reserved.
//

import Foundation
import Alamofire
import UIKit

enum SPLTFullPathRouter: URLConvertible {
    
    case imageFullPath(String)
    case imagePath(String, Int, Int)
    //    case ImagePathReplacingToMySpotlight(String, Int, Int)
    case spotlightAPICategories
    case spotlightAPIChannels
    case play_TIME_API
    case player_API
    case dtsz_PLAYER_ANALYTICS
    case dtsz_SHARE_ANALYTICS
    
    // MARK: URLStringConvertible
    var URLString: String {
        let path: String = {
            switch self {
            case .imageFullPath(let strImageId):
                return "http://image.myspotlight.tv/\(strImageId)"
            case .imagePath(let strImagePath, let imageViewWidth, let imageViewHeight):
                let finalImaveViewWidth = Int(CGFloat(imageViewWidth) * UIScreen.main.scale)
                let finalImaveViewHeight = Int(CGFloat(imageViewHeight) * UIScreen.main.scale)
                return strImagePath + "/\(finalImaveViewWidth)/\(finalImaveViewHeight)"
                
            case .spotlightAPICategories:
                //                return "http://myspotlight.tv/categories/list"
                return "https://myspotlight.tv/categories/list"
            case .spotlightAPIChannels:
                //                return "http://myspotlight.tv/json/channels"
                return "https://myspotlight.tv/json/channels"
            case .play_TIME_API:
                return "https://collector.dotstudiopro.com/plays"
            case .player_API:
                return "https://collector.dotstudiopro.com/players"
            case .dtsz_PLAYER_ANALYTICS:
                #if USE_TEST_COLLECTOR_API
                    return "http://dev.collector.myspotlight.tv/collect"
                #else
                    return "https://collector.myspotlight.tv/collect"
                #endif
            case .dtsz_SHARE_ANALYTICS:
                #if USE_TEST_COLLECTOR_API
                    return "http://dev.collector.myspotlight.tv/shared"
                #else
                    return "https://collector.myspotlight.tv/shared"
                #endif
            }
        }()
        return path
    }
    
    func asURL() throws -> URL {
        let result: (path: String, parameters: Parameters) = {
            switch self {
                case .imageFullPath(let strImageId):
                    return ("http://image.myspotlight.tv/\(strImageId)", [:])
                case .imagePath(let strImagePath, let imageViewWidth, let imageViewHeight):
                    let finalImaveViewWidth = Int(CGFloat(imageViewWidth) * UIScreen.main.scale)
                    let finalImaveViewHeight = Int(CGFloat(imageViewHeight) * UIScreen.main.scale)
                    return ("\(strImagePath)/\(finalImaveViewWidth)/\(finalImaveViewHeight)", [:])
                case .spotlightAPICategories:
                    return ("https://myspotlight.tv/categories/list", [:])
                case .spotlightAPIChannels:
                    return ("https://myspotlight.tv/json/channels", [:])
                case .play_TIME_API:
                    return ("https://collector.dotstudiopro.com/plays", [:])
                case .player_API:
                    return ("https://collector.dotstudiopro.com/players", [:])
                case .dtsz_PLAYER_ANALYTICS:
                    #if USE_TEST_COLLECTOR_API
                        return ("http://dev.collector.myspotlight.tv/collect", [:])
                    #else
                        return ("https://collector.myspotlight.tv/collect", [:])
                    #endif
                case .dtsz_SHARE_ANALYTICS:
                    #if USE_TEST_COLLECTOR_API
                        return ("http://dev.collector.myspotlight.tv/shared", [:])
                    #else
                        return ("https://collector.myspotlight.tv/shared", [:])
                    #endif
                
            }
        }()
        
        let url = result.path //try "".asURL() //SPLTRouter.BASE_URL.asURL()
        let finalUrl = try url.asURL() //url.appendingPathComponent(result.path)
        return try finalUrl
    }
    
    
}








