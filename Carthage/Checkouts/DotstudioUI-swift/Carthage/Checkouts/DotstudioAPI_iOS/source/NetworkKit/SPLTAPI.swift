//
//  SPLTAPI.swift
//  DotstudioPRO
//
//  Created by ketan on 17/02/16.
//  Copyright © 2016 ___DotStudioz___. All rights reserved.
//

import Foundation
import Alamofire
import UIKit

public enum SPLTRouter: URLConvertible {
    
    static let BUNDLE_IDENTIFIER = Bundle.main.infoDictionary!["CFBundleIdentifier"] as! String
    static let BASE_URL = "https://api.myspotlight.tv" //"http://dev.api.myspotlight.tv"
    static let COUNTRY_CODE: String = (Locale.current as NSLocale).object(forKey: NSLocale.Key.countryCode) as! String
    
//    static let baseUniversalURLString = "https://api.dotstudiopro.com/v2/\(universalKey)/json/videos"

    public static var API_KEY = ""

    static var strAccessToken: String? {
        didSet {
            if let strAccessToken = SPLTRouter.strAccessToken {
                
                do {
                    let jwt = try decode(strAccessToken)
                    if let strCompanyId = jwt.body["iss"] as? String {
                        self.str_company_id = strCompanyId
                    }
                } catch {
                    print("Something went wrong while retrieving company id from access token!")
                }
                
                SPLTBaseAPI.spltTokenHandler = SPLTTokenHandler(
                    API_KEY: SPLTRouter.API_KEY, //"12345678",
                    baseURLString: SPLTRouter.BASE_URL, //baseURLString,
                    accessToken: strAccessToken, //"abcd1234",
                    clientToken: SPLTRouter.strClientToken //"ef56789a"
                )
            }
        }
    }
    static var strClientToken: String? {
        didSet {
            SPLTUser.sharedInstance.updateUserId()
//            if (strClientToken == nil) {
//                SPLTUser.sharedInstance.userId = nil
//            } 
            if let strAccessToken = SPLTRouter.strAccessToken {
                SPLTBaseAPI.spltTokenHandler = SPLTTokenHandler(
                    API_KEY: SPLTRouter.API_KEY, //"12345678",
                    baseURLString: SPLTRouter.BASE_URL, //baseURLString,
                    accessToken: strAccessToken, //"abcd1234",
                    clientToken: SPLTRouter.strClientToken //"ef56789a"
                )
            }
        }
    }
    
    static var str_company_id: String?
    
    case root
    case token
    case refreshToken
    case categories
    case channels
    case channels_Lean
    case channel(String)
    case channel_Partial(String)
    case categoryChannels(String)
    case categoryChannelsLean(String)
    case purchasedCategoryChannel(String)
    case categoryChannel(String, String)
    case categoryChannelVideo(String, String, String)
    case catChannelVideo(String, String)
    
//    case register
//    case login
    case userDetail
    case purchaseVideo
    case searchSuggesion(String)
    case searchTerm(String)
    case searchVideoTerm(String)
    case orderDetail
//    case forgotPassword
    case changePassword
    case getProfile
    case updateProfile
    case updateAvatar
    case getAvatarImage(String)
    case getChannelInfo(String)
    case videoDetail(String)
    case videoPlay2(String)
    case setVideoProgress(String, Int)
    case getVideoProgress(String)
    case getVideoProgressForVideos()
    case getResumptionVideos
    case getAdTags(String, Int, Int)
    case searchChannels
    case companyChannels(String)
    case playlistDetail(String)
    case spotlightAPICategories
    case spotlightAPIChannels
    case play_TIME_API
    case player_API
    case recommandationVideo(String)
    case recommandationChannel(String)
//    case dtsz_PLAYER_ANALYTICS
//    case dtsz_SHARE_ANALYTICS
    case testingAnalytics
    case latestAppVersion
    
    // MARK: URLStringConvertible
    var URLString: String {
        let path: String = {
            switch self {
            case .root:
                return "/"
            case .token:
                return SPLTRouter.BASE_URL + "/token"
            case .refreshToken:
                return SPLTRouter.BASE_URL + "/users/token/refresh"
            case .categories:
                return SPLTRouter.BASE_URL + "/categories/" + SPLTRouter.COUNTRY_CODE
            case .channels:
                return SPLTRouter.BASE_URL + "/channels/" + SPLTRouter.COUNTRY_CODE
            case .channels_Lean:
                return SPLTRouter.BASE_URL + "/channels/" + SPLTRouter.COUNTRY_CODE + "?detail=lean"
            case .channel(let strChannelSlug):
                return SPLTRouter.BASE_URL + "/channel/" + SPLTRouter.COUNTRY_CODE + "/\(strChannelSlug)"
            case .channel_Partial(let strChannelSlug):
                return SPLTRouter.BASE_URL + "/channel/" + SPLTRouter.COUNTRY_CODE + "/\(strChannelSlug)?detail=partial"
            case .categoryChannels(let strCategorySlug):
                return SPLTRouter.BASE_URL + "/channels/" + SPLTRouter.COUNTRY_CODE + "/\(strCategorySlug)"
            case .categoryChannelsLean(let strCategorySlug):
                return SPLTRouter.BASE_URL + "/channels/" + SPLTRouter.COUNTRY_CODE + "/\(strCategorySlug)?detail=lean"
            case .purchasedCategoryChannel(let strPurchasedCategoryChannelSlug):
                return SPLTRouter.BASE_URL + "/channels/" + SPLTRouter.COUNTRY_CODE + "/" + strPurchasedCategoryChannelSlug
            case .categoryChannel(let strCategorySlug, let strChannelSlug):
                return SPLTRouter.BASE_URL + "/channels/" + SPLTRouter.COUNTRY_CODE + "/" + strCategorySlug + "/" + strChannelSlug
            case .categoryChannelVideo(let strCategorySlug, let strChannelSlug, let strVideoId):
                return SPLTRouter.BASE_URL + "/channels/" + SPLTRouter.COUNTRY_CODE + "/" + strCategorySlug + "/" + strChannelSlug + "/play/" + strVideoId
            case .catChannelVideo(let strCategoryChannelSlug, let strVideoId):
                return SPLTRouter.BASE_URL + "/channels/" + SPLTRouter.COUNTRY_CODE + "/" + strCategoryChannelSlug + "/play/" + strVideoId
//            case .register:
//                return "https://api.dotstudiopro.com/v2/universalapi/customer_register"
//            case .login:
//                return SPLTRouter.BASE_URL + "/users/login"
            case .userDetail:
                return SPLTRouter.BASE_URL + "/users/details"
            case .purchaseVideo:
                return SPLTRouter.BASE_URL + "/users/payment/apple"
            case .searchSuggesion(let strSearchTerm):
                let searchSuggesionUrl:String = SPLTRouter.BASE_URL + "/search/s/?q=\(strSearchTerm)"
                return searchSuggesionUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
            case .searchTerm(let strSearchTerm):
                let searchTermUrl:String = SPLTRouter.BASE_URL + "/search/?q=\(strSearchTerm)"
                return searchTermUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
            case .searchVideoTerm(let strSearchTerm):
                let searchVideoTermUrl = SPLTRouter.BASE_URL + "/search/videos/?q=\(strSearchTerm)"
                return searchVideoTermUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
            case .orderDetail:
                return SPLTRouter.BASE_URL + "/users/orders/history"
//            case .forgotPassword:
//                return "https://api.dotstudiopro.com/v2/universalapi/forgotpassword"
            case .changePassword:
                return SPLTRouter.BASE_URL + "/users/password"
            case .getProfile:
                return "https://api.dotstudiopro.com/v2/universalapi/customer_details"
            case .updateProfile:
                return "https://api.dotstudiopro.com/v2/universalapi/customer_details/edit"
            case .updateAvatar:
                return SPLTRouter.BASE_URL + "/users/avatar/"
            case .getAvatarImage(let strUserId):
                return "http://myspotlight.tv/user/avatar/\(strUserId)"
            case .getChannelInfo(let channelSlug):
                return "http://myspotlight.tv/json/channels/\(channelSlug)"
            case .videoDetail(let videoId):
                return SPLTRouter.BASE_URL + "/video/play/\(videoId)"
            case .videoPlay2(let videoId):
                return SPLTRouter.BASE_URL + "/video/play2/\(videoId)"
            case .setVideoProgress(let videoId, let videoDuration):
                return SPLTRouter.BASE_URL + "/users/videos/point/" + videoId + "/\(videoDuration)"
            case .getVideoProgress(let videoId):
                return SPLTRouter.BASE_URL + "/users/videos/point/" + videoId
            case .getVideoProgressForVideos():
                return SPLTRouter.BASE_URL + "/users/videos/points"
            case .getResumptionVideos:
                return SPLTRouter.BASE_URL + "/users/resumption/videos"
            case .getAdTags(let videoId, let width, let height):
                var strAdTagUrl = "/vmap/adtag/\(videoId)/\(width)/\(height)"
                #if os(iOS)
                    strAdTagUrl += "?device_type=ios"
                #elseif os(tvOS)
                    strAdTagUrl += "?device_type=apple_tv"
                #endif
//                if let strVmapAdTagParameters = K10Utility.getVmapAdTagParameters() {
//                    strAdTagUrl += "?\(strVmapAdTagParameters)"
//                }
                return SPLTRouter.BASE_URL + strAdTagUrl
            case .searchChannels:
                return "http://myspotlight.tv/m/search"
            case .companyChannels(let companyName):
                return "http://myspotlight.tv/company/\(companyName)/json"
            case .playlistDetail(let playlistId):
                return "https://api.dotstudiopro.com/v2/cc89512b/json/playlists/\(playlistId)"
            case .spotlightAPICategories:
                //                return "http://myspotlight.tv/categories/list"
                return "http://myspotlight.tv/categories/list"
            case .spotlightAPIChannels:
                //                return "http://myspotlight.tv/json/channels"
                return "http://myspotlight.tv/json/channels"
            case .play_TIME_API:
                return "https://collector.dotstudiopro.com/plays"
            case .player_API:
                return "https://collector.dotstudiopro.com/players"
                
            case .recommandationVideo(let videoId):
                return SPLTRouter.BASE_URL + "/search/recommendation?q=\(videoId)&size=20&from=0"
            case .recommandationChannel(let channelId):
                return SPLTRouter.BASE_URL + "/search/recommendation/channel?q=\(channelId)&size=20&from=0"
            case .testingAnalytics:
                return SPLTRouter.BASE_URL + "/testing/analytics"
            case .latestAppVersion:
                #if os(iOS)
                    return SPLTRouter.BASE_URL + "/latestAppVersion/ios"
                #else
                    return SPLTRouter.BASE_URL + "/latestAppVersion/apple_tv"
                #endif
            }
        }()
        return path
    }
    
    public func asURL() throws -> URL {
        let result: (path: String, parameters: Parameters) = {
            switch self {
                case .root:
                    return ("/", [:]) //, ["q": query, "offset": SPLTRouter.perPage * page])
                case .token:
                    return ("/token", [:]) //, ["q": query, "offset": SPLTRouter.perPage * page])
                case .refreshToken:
                    return ("/users/token/refresh", [:])
                case .categories:
                    return ("/categories/\(SPLTRouter.COUNTRY_CODE)", [:])
                case .channels:
                    return ("/channels/\(SPLTRouter.COUNTRY_CODE)", [:])
                case .channels_Lean:
//                    return ("/channels/\(SPLTRouter.COUNTRY_CODE)", ["detail":"lean"])
                    let finalUrl = "/channels/\(SPLTRouter.COUNTRY_CODE)?detail=lean"
                    return (finalUrl, [:])
                case .channel(let strChannelSlug):
                    return ("/channel/\(SPLTRouter.COUNTRY_CODE)/\(strChannelSlug)", [:])
                case .channel_Partial(let strChannelSlug):
                    return ("/channel/\(SPLTRouter.COUNTRY_CODE)/\(strChannelSlug)?detail=partial", [:])
                case .categoryChannels(let strCategorySlug):
                    return ("/channels/\(SPLTRouter.COUNTRY_CODE)/\(strCategorySlug)", [:])
                case .categoryChannelsLean(let strCategorySlug):
                    let finalUrl = "/channels/\(SPLTRouter.COUNTRY_CODE)/\(strCategorySlug)?detail=lean" //?detail=lean"
                    return (finalUrl, [:])
//                    return ("/channels/\(SPLTRouter.COUNTRY_CODE)/\(strCategorySlug)?detail=lean", [:])
                case .purchasedCategoryChannel(let strPurchasedCategoryChannelSlug):
                    return ("/channels/\(SPLTRouter.COUNTRY_CODE)/\(strPurchasedCategoryChannelSlug)", [:])
                case .categoryChannel(let strCategorySlug, let strChannelSlug):
                    return ("/channels/\(SPLTRouter.COUNTRY_CODE)/\(strCategorySlug)/\(strChannelSlug)", [:])
                case .categoryChannelVideo(let strCategorySlug, let strChannelSlug, let strVideoId):
                    return ("/channels/\(SPLTRouter.COUNTRY_CODE)/\(strCategorySlug)/\(strChannelSlug)/play/\(strVideoId)", [:])
                case .catChannelVideo(let strCategoryChannelSlug, let strVideoId):
                    return ("/channels/\(SPLTRouter.COUNTRY_CODE)/\(strCategoryChannelSlug)/play/\(strVideoId)", [:])
//                case .register:
//                    return "https://api.dotstudiopro.com/v2/universalapi/customer_register"
//                case .login:
//                    return SPLTRouter.BASE_URL + "/users/login"
                case .userDetail:
                    return ("/users/details", [:])
                case .purchaseVideo:
                    return ("/users/payment/apple", [:])
                case .searchSuggesion(let strSearchTerm):
                    let searchSuggesionTermUrl = "/search/s/?q=\(strSearchTerm)"
                    let finalUrl = searchSuggesionTermUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
                    return (finalUrl, [:])
                case .searchTerm(let strSearchTerm):
                    let searchTermUrl = "/search/?q=\(strSearchTerm)"
                    let finalUrl = searchTermUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
                    return (finalUrl, [:])
                case .searchVideoTerm(let strSearchTerm):
                    let searchVideoTermUrl = "/search/videos?q=\(strSearchTerm)"
                    //let finalUrl = searchVideoTermUrl.addingPercentEscapes(using: String.Encoding.utf8)!
                    let finalUrl = searchVideoTermUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
                    return (finalUrl, [:])
                case .orderDetail:
                    return ("/users/orders/history", [:])
                case .getProfile:
                    return ("/customer_details", [:])
//                    return "https://api.dotstudiopro.com/v2/universalapi/customer_details"
                case .updateProfile:
                    return ("/customer_details/edit", [:])
//                    return "https://api.dotstudiopro.com/v2/universalapi/customer_details/edit"
                case .updateAvatar:
                    return ("/users/avatar", [:])
//                    return SPLTRouter.BASE_URL + "/users/avatar/"
                case .getAvatarImage(let strUserId):
                    return ("/user/avatar/\(strUserId)", [:])
//                    return "http://myspotlight.tv/user/avatar/\(strUserId)"
//                case .getChannelInfo(let channelSlug):
//                    return "http://myspotlight.tv/json/channels/\(channelSlug)"
                case .videoDetail(let videoId):
                    return ("/video/play/\(videoId)", [:])
                case .videoPlay2(let videoId):
                    return ("/video/play2/\(videoId)", [:])
                case .setVideoProgress(let videoId, let videoDuration):
                    return ("/users/videos/point/\(videoId)/\(videoDuration)", [:])
                case .getVideoProgress(let videoId):
                    return ("/users/videos/point/\(videoId)", [:])
                case .getVideoProgressForVideos():
                    return ("/users/videos/points", [:])
                case .getResumptionVideos:
                    return ("/users/resumption/videos", [:])
                case .getAdTags(let videoId, let width, let height):
                    var strAdTagUrl = "/vmap/adtag/\(videoId)/\(width)/\(height)"
                    #if os(iOS)
                        strAdTagUrl += "?device_type=ios"
                    #elseif os(tvOS)
                        strAdTagUrl += "?device_type=apple_tv"
                    #endif
//                    if let strVmapAdTagParameters = SPLTRouter.getVmapAdTagParameters() {
//                        strAdTagUrl += "?\(strVmapAdTagParameters)"
//                    }
                    return (strAdTagUrl, [:])
                case .recommandationVideo(let videoId):
                    return ("/search/recommendation?q=\(videoId)&size=20&from=0", [:])
                case .recommandationChannel(let channelId):
                    return ("/search/recommendation/channel?q=\(channelId)&size=20&from=0", [:])
                case .testingAnalytics:
                    return ("/testing/analytics", [:])
                case .latestAppVersion:
                    #if os(iOS)
                        return ("/latestAppVersion/ios", [:])
                    #else
                        return ("/latestAppVersion/apple_tv", [:])
                    #endif
                default:
                    return ("", [:])
            }
        }()

        let strBaseUrl = SPLTRouter.BASE_URL
        let strUrl = strBaseUrl.appending(result.path)
        let strFinalUrl = strUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
//        let strFinalUrl = strUrl.addingPercentEscapes(using: String.Encoding.utf8)!
        let url = try strFinalUrl.asURL()
        return url
        
//        return searchSuggesionUrl.addingPercentEscapes(using: String.Encoding.utf8)!

//        let url = try SPLTRouter.BASE_URL.asURL()
//        let finalUrl = url.appendingPathComponent(result.path)
//        return try finalUrl
    }


}


open class SPLTAPI {
    
    // With Block methods
    open func regenerateAccessTokenAndGetJSONResponse(_ strUrl: String, completion: @escaping (_ dictionary: [String: AnyObject]) -> Void, completionError: @escaping (_ error: NSError) -> Void) {
        SPLTTokenAPI().getToken { (strToken) -> Void in
            self.getJSONResponse(strUrl, completion: completion, completionError: completionError)
        }
    }
    
    open func getJSONResponse(_ strUrl: String, completion: @escaping (_ dictionary: [String: AnyObject]) -> Void, completionError: @escaping (_ error: NSError) -> Void) {
        
        if (SPLTRouter.strAccessToken == nil) {
            self.regenerateAccessTokenAndGetJSONResponse(strUrl, completion: completion, completionError: completionError)
            return
        }
        
        //let strUrl: URLConvertible = SPLTRouter.categories.URLString
        let headers = [
            "x-access-token": SPLTRouter.strAccessToken!,
            ]

            Alamofire.request(SPLTRouter.categories, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headers).validate().responseJSON { (response) in
                        if let httpURLResponse = response.response {
                            if (httpURLResponse.statusCode == 403) {
                                // regenerate accesstoken
                                self.regenerateAccessTokenAndGetJSONResponse(strUrl, completion: completion, completionError: completionError)
                                return
                            }
                        }
                        if (response.result.value != nil) {
                            if let infoDict = response.result.value as? [String: AnyObject] {
                                completion(infoDict)
                            }
                        }
                        completionError(NSError(domain: "SPLTAPI", code: 1, userInfo: nil))
            }
    }
}






