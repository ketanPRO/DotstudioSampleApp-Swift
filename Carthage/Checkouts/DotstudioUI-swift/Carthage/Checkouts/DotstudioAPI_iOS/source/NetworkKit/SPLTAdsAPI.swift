//
//  SPLTAdsAPI.swift
//  DotstudioPRO
//
//  Created by Ketan Sakariya on 09/05/17.
//  Copyright © 2017 ___DotStudioz___. All rights reserved.
//

import Foundation
import Alamofire
import AdSupport

open class SPLTAdsAPI {
    
    func getVmapAdTagParameters() -> String? {
        //            vpaid
        //            app_bundle
        //            app_idfa
        //            user_yob - optional
        //            user_gender - optional
        // app_name
        var strAdTagParameters: String = "vpaid=js"
        if let strBundleIdentifier = Bundle.main.bundleIdentifier {
            strAdTagParameters += "&app_bundle=\(strBundleIdentifier)"
        }
        //strApplicationUUID_ = UIDevice.current.identifierForVendor!.uuidString
        let strBundleIdfa = ASIdentifierManager.shared().advertisingIdentifier.uuidString
        strAdTagParameters += "&app_idfa=\(strBundleIdfa)"
        
        if let strAppName = Bundle.main.infoDictionary?["DTSZ_APPNAME"] as? String {
            strAdTagParameters += "&app_name=\(strAppName)"
        }
        
        // Additional Params for TV
        //http://search.spotxchange.com/vast/2.0/85394?VPI=MP4&app[bundle]=REPLACE_ME&player_height=1080&player_width=1920&device[devicetype]=7&device[make]=Apple&device[model]=Apple%20TV&app[name]=REPLACE_ME
        //            app_name
        //            device_make
        //            device_model
        //            device_type
        //            vpi
        #if os(tvOS)
            //                if let strAppName = Bundle.main.infoDictionary?["DTSZ_APPNAME"] as? String {
            //                    strAdTagParameters += "app_name=\(strAppName)"
            //                }
            strAdTagParameters += "&device_make=Apple"
            strAdTagParameters += "&device_model=Apple%20TV"
            strAdTagParameters += "&device_type=7"
            strAdTagParameters += "&vpi=MP4"
        #endif
        return strAdTagParameters
    }
    
    open func getAdTagForVideo(_ strVideoId: String, width: Int, height: Int, completion: @escaping (_ adTagsDict: [String: AnyObject]) -> Void, completionError: @escaping (_ error: NSError) -> Void) {
        
        var strAdTagUrl = SPLTRouter.getAdTags(strVideoId, width, height).URLString
        if let strVmapAdTagParameters = self.getVmapAdTagParameters() {
            strAdTagUrl += "?\(strVmapAdTagParameters)"
        }

        let headers = ["device-type":"AppleTV"]
        SPLTBaseAPI.sessionManager.request(strAdTagUrl, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headers).validate().responseJSON { (response) in
            //                debugPrint(response)
            if (response.result.value != nil) {
                if let infoDict = response.result.value as? [String: AnyObject],
                    let bSuccess = infoDict["success"] as? Bool, bSuccess == true,
                    let tagsDict = infoDict["tags"] as? [String: AnyObject] {
                    completion(tagsDict)
                    return
                }
            }
            completionError(NSError(domain: "SPLTAdsAPI", code: 1, userInfo: nil))
        }
    }
}






