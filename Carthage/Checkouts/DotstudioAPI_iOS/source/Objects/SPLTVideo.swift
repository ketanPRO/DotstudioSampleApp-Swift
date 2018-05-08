//
//  SPLTVideo.swift
//  DotstudioPRO
//
//  Created by ketan on 08/04/16.
//  Copyright © 2016 ___DotStudioz___. All rights reserved.
//

import Foundation
import UIKit

public protocol SPLTVideoDelegate {
    func didUpdateVideo()
    func didUpdateVideoProgressDuration()
}

// Screen enumerators for view controllers
enum SPLTVideoAdType { //: Int {
    case none, // = 0,
    preroll,
    midroll,
    postroll
}

open class SPLTVideo: NSObject {
    
    var isExpandedUI: Bool = false
    var bVideoUpdated: Bool = false
    var isGeoblocked: Bool = false
//    var playlistVideolDict: [String: AnyObject] {
//        didSet {
//        }
//    }
    var delegate: SPLTVideoDelegate?
    var videoDict: [String: AnyObject] = [:] {
        didSet {
        }
    }
    var searchResultVideoDict: [String: AnyObject] = [:] {
        didSet {
            self.videoDict = searchResultVideoDict
        }
    }
    
    var strId: String? {
        didSet {
            #if !APP_BTVR
                //self.updateVideoProgress()
            #endif
        }
    }
    var strComapnyId: String?
    var strTitle: String?
    var strSeriesTitle: String?
    var strDescription: String?
//    var company_logo: String?
    var isVideoWaterMarkingEnabled: Bool = false
    var strVideoWaterMarkId: String?
    var fWaterMarkOpacity: CGFloat?
    var strSlug: String?
    var poster: String?
    var thumb: String?
    var thumbs: [String] = []
    var wallpaper: String?
    var progressPoint: Int? {
        didSet {
            if progressPoint == nil {
                self.strProgressDuration = ""
            } else {
//                let dateComponentsFormatter: DateComponentsFormatter = DateComponentsFormatter()
//                self.strProgressDuration = dateComponentsFormatter.string(from: TimeInterval(progressPoint!))!
                let interval = Int(progressPoint!)
                let seconds = interval % 60
                let minutes = (interval / 60) % 60
                let hours = (interval / 3600)
                if hours <= 0 {
                    self.strProgressDuration = String(format: "%02d:%02d", minutes, seconds)
                } else {
                    self.strProgressDuration = String(format: "%02d:%02d:%02d", hours, minutes, seconds)
                }
            }
        }
    }
    var strProgressDuration: String = ""
    
    var actors: [String] = []
    
    var strVideoUrl: String?
    var strCloseCaptionUrl: String?
    
    var strCategoryName: String?
    var strCategorySlug: String?
    var strChannelSlug: String?
    
    static let DURATION_THRESHOLD: Int = 30
    var iDuration: Int = 0
    
    var strYear: String?
    var strRating: String?
    var strLanguage: String?
    var strCompanyName: String?
    var strCountryName: String?

    var strVideoInfo: String?
    var mutableAttributedStringVideoInfo: NSMutableAttributedString?
    
    var adType_mid: Bool = true
    var adType_pre: Bool = true
    var adType_post: Bool = true
    var adType_over: Bool = true
//    var midRollAdBreaks: [Int] = []
    var midRollAdBreaksDict: [[String: Any]] = []
    var adsTagsDict: [String: AnyObject]?

    var hasPlayedAdType_Pre: Bool = false
    var hasPlayedAdType_Mid: Bool = false
    var hasPlayedAdType_Post: Bool = false

    
    var spltVideoAPI: SPLTVideoAPI?

    override init() {
        super.init()
    }
    init(videoDict: [String: AnyObject]) {
        super.init()
        self.videoDict = videoDict
        self.mapFromVideoDict(videoDict)
    }
    init(searchResultVideoDict: [String: AnyObject]) {
        super.init()
        self.searchResultVideoDict = searchResultVideoDict
        self.mapFromSearchResultVideoDict(searchResultVideoDict)
    }
    
    func resetAdPlayedData() {
        self.hasPlayedAdType_Pre = false
        self.hasPlayedAdType_Mid = false
        self.hasPlayedAdType_Post = false
        self.midRollAdBreaksDict.removeAll()
    }
    
    func mapFromVideoDict(_ videoDict: [String: AnyObject]) {
        if let strId = videoDict["_id"] as? String {
            self.strId = strId
        }
        if let strComapnyId = videoDict["company_id"] as? String {
            self.strComapnyId = strComapnyId
        }
        if let strTitle = videoDict["title"] as? String {
            self.strTitle = strTitle
        }
        if let strSeriesTitle = videoDict["seriestitle"] as? String {
            self.strSeriesTitle = strSeriesTitle
        }
        if let strDescription = videoDict["description"] as? String {
            self.strDescription = strDescription
        }
        if let isVideoWaterMarkingEnabled = videoDict["videowatermarking"] as? Bool {
            self.isVideoWaterMarkingEnabled = isVideoWaterMarkingEnabled
        }
        if let dictComapny = videoDict["company"] as? [String: AnyObject] {
            if let dictWatermark = dictComapny["watermark"] as? [String: AnyObject] {
                if let strVideoWaterMarkId = dictWatermark["logo"] as? String {
                    self.strVideoWaterMarkId = strVideoWaterMarkId
                }
                if let fWaterMarkOpacity = dictWatermark["opacity"] as? CGFloat {
                    self.fWaterMarkOpacity = fWaterMarkOpacity
                } else if let strWaterMarkOpacity = dictWatermark["opacity"] as? String {
                    if let fWaterMarkOpacity = Float(strWaterMarkOpacity) {
                        self.fWaterMarkOpacity = CGFloat(fWaterMarkOpacity)
                    }
                }
            }
        }
        
        if let strDuration = videoDict["duration"] as? String {
            if let fDuration = Float(strDuration) {
                if !fDuration.isNaN {
                    self.iDuration = Int(fDuration)
                }
            }
        } else if let fDuration = videoDict["duration"] as? Float {
            if !fDuration.isNaN {
                self.iDuration = Int(fDuration)
            }
        }

        
        if let strSlug = videoDict["slug"] as? String {
            self.strSlug = strSlug
        }
        if let poster = videoDict["poster"] as? String, poster != "" {
            self.poster = poster
        }
        if let thumbId = videoDict["thumb"] as? String {
            if (thumbId.range(of: "http:") == nil) && (thumbId.range(of: "https:") == nil) {
                self.thumb = SPLTFullPathRouter.imageFullPath(thumbId).URLString
            } else {
                self.thumb = thumbId
            }
        }
        if let strThumbIds = videoDict["thumbs"] as? [String] {
            self.thumbs.removeAll()
            for strThumbId in strThumbIds {
                let thumb = SPLTFullPathRouter.imageFullPath(strThumbId).URLString
                self.thumbs.append(thumb)
            }
        }

        if let wallpaper = videoDict["wallpaper"] as? String, wallpaper != "" {
            self.wallpaper = wallpaper
        }
        
        if let actors = videoDict["actors"] as? [String] {
            self.actors = actors
        }
        
        if let video_m3u8 = videoDict["video_m3u8"] as? String {
            if video_m3u8.hasPrefix("http") {
                self.strVideoUrl = video_m3u8
            } else {
                self.strVideoUrl = "https://".appending(video_m3u8)
            }
//        } else {
//            if let strComapnyId_ = self.strComapnyId, let strVideoId_ = self.strId {
//                self.strVideoUrl = "https://k7q5a5e5.ssl.hwcdn.net/files/company/\(strComapnyId_)/assets/videos/\(strVideoId_)/vod/\(strVideoId_).m3u8"
//            }
        }

        if let arrayCloseCaption = videoDict["closeCaption"] as? [[String: AnyObject]] {
            for dictCloseCpation in arrayCloseCaption {
                if let srtExt = dictCloseCpation["srtExt"] as? String, srtExt == "srt" {
                    if let srtPath = dictCloseCpation["srtPath"] as? String {
                        if srtPath.hasPrefix("http") {
                            self.strCloseCaptionUrl = srtPath
                        } else {
                            self.strCloseCaptionUrl = "https://".appending(srtPath)
                        }
                        break
                    }
                }
            }
        }
        
        
        if let strCategoryName = videoDict["category"] as? String {
            self.strCategoryName = strCategoryName
        }
        if let strYear = videoDict["year"] as? String {
            self.strYear = strYear
        }
        if let strRating = videoDict["rating"] as? String {
            self.strRating = strRating
        }
        if let strLanguage = videoDict["language"] as? String {
            self.strLanguage = strLanguage
        }
        if let strCountryName = videoDict["country"] as? String {
            self.strCountryName = strCountryName
        }
        if let strCompanyName = videoDict["company"] as? String {
            self.strCompanyName = strCompanyName
        }
        
        self.updateVideoInfo()
        
        if let adsDict = videoDict["ads"] as? [String: AnyObject] {
//            #if USE_PLAY2_ROUTE
//                if let iosads_breaksDict = dataDict["ad_tag"] as? [String: AnyObject] {
//                    self.iosads_breaksDict = iosads_breaksDict
//                }
//            #else
//                if let iosads_breaksDict = dataDict["iosads_breaks"] as? [String: AnyObject] {
//                    self.iosads_breaksDict = iosads_breaksDict
//                }
//            #endif
            self.setUpAdsFromAdDictionary(adsDict)
        }

        
        #if USE_NEW_CHANNEL_SCREEN
        #else
            if (self.strSlug == nil) {
                self.requestVideoDetail()
            } else if (self.poster == nil && self.thumb == nil) {
              self.requestVideoDetail()
            }
        #endif
        
        
        
        
        
        
    }
    
    func updateVideoInfo() {
        var strVideoInfo: String = ""
        var strVideoSubInfos: [String] = []
        if let strCategory = self.strCategoryName, strCategory != "" {
            strVideoSubInfos.append(strCategory)
            //strVideoInfo = "\(strCategory) | "
        }
        if let strYear = self.strYear, strYear != "" {
            strVideoSubInfos.append(strYear)
            //strVideoInfo += "\(strYear) | "
        }
        if let strRating = self.strRating, strRating != "" {
            strVideoSubInfos.append(strRating)
            //strVideoInfo += "\(strRating) | "
        }
        if let strLanguage = self.strLanguage, strLanguage != "" {
            strVideoSubInfos.append(strLanguage)
            //strVideoInfo += "\(strLanguage) | "
        }
        if let strCountry = self.strCountryName, strCountryName != "" {
            strVideoSubInfos.append(strCountry)
            //strVideoInfo += "\(strCountry) | "
        }
        
        let iStringLengthBeforeCompanyName: Int = strVideoInfo.characters.count
        var strCompanyName: String?
        if let strCompany = self.strCompanyName, strCompanyName != "" {
            strVideoSubInfos.append(strCompany.uppercased())
            //strVideoInfo += "\(strCompany.uppercased())"
            strCompanyName = strCompany
        }
        
        
        for (index,strVideoSubInfo) in strVideoSubInfos.enumerated() {
            if index == 0 {
                strVideoInfo += "\(strVideoSubInfo)"
            } else {
                strVideoInfo += " | \(strVideoSubInfo)"
            }
        }
        self.strVideoInfo = strVideoInfo


//        let spotlightFont: UIFont = UIFont.systemFont(ofSize: 11.0) //UIFont.preferredFont(forTextStyle: UIFontTextStyle.subheadline)
//        let myMutableString: NSMutableAttributedString = NSMutableAttributedString(string: strVideoInfo, attributes: [NSAttributedStringKey.font:spotlightFont])
//        if let lightFontColor = K10Theme.lightFontColor {
//            myMutableString.addAttribute(NSAttributedStringKey.foregroundColor, value: lightFontColor, range: NSMakeRange(0, strVideoInfo.characters.count))
//        }
//
//        if (strCompanyName != nil) {
//            let iStringLengthAfterCompanyName: Int = strVideoInfo.characters.count
//            let range: NSRange = NSMakeRange(iStringLengthBeforeCompanyName, (iStringLengthAfterCompanyName - iStringLengthBeforeCompanyName))
//            if let corporateColor = K10Theme.corporateColor {
//                myMutableString.addAttribute(NSAttributedStringKey.foregroundColor, value: corporateColor, range: range)
//            }
//        }
//        self.mutableAttributedStringVideoInfo = myMutableString
    }
    
    
    func mapFromSearchResultVideoDict(_ searchResultVideoDict: [String: AnyObject]) {
        if let strId = searchResultVideoDict["_id"] as? String {
            self.strId = strId
        }
        if let _sourceDict = searchResultVideoDict["_source"] as? [String: AnyObject] {
            if let strTitle = _sourceDict["title"] as? String {
                self.strTitle = strTitle
            }
            if let strSeriesTitle = _sourceDict["seriestitle"] as? String {
                self.strSeriesTitle = strSeriesTitle
            }
            if let thumbId = _sourceDict["thumb"] as? String {
                self.thumb = SPLTFullPathRouter.imageFullPath(thumbId).URLString
            }
        }


        if (self.poster == nil && self.thumb == nil) {
              self.requestVideoDetail()
        }
    }
    
    func mapFromVideoAPIDict(_ videoDict: [String: AnyObject]) {
        self.mapFromVideoDict(videoDict)
        if let bGeoCheck = videoDict["geoCheck"] as? Bool, bGeoCheck == false {
            self.isGeoblocked = true
        }
        if let dictCustomFields = videoDict["custom_fields"] as? [[String: AnyObject]] {
            for dictCustomField in dictCustomFields {
                if let strCustomFieldTitle = dictCustomField["field_title"] as? String, let strCustomFieldValue = dictCustomField["field_value"] as? String, strCustomFieldTitle == "category_name" {
                    self.strCategoryName = strCustomFieldValue
                }
                if let strCustomFieldTitle = dictCustomField["field_title"] as? String, let strCustomFieldValue = dictCustomField["field_value"] as? String, strCustomFieldTitle == "channel_slug" {
                    self.strChannelSlug = strCustomFieldValue
                }
            }
        }
//        "custom_fields": [
//        {
//        "field_title": "category_name",
//        "field_value": "Learn"
//        },
//        {
//        "field_title": "channel_slug",
//        "field_value": "millennial-dads"
//        },
//        {
//        "field_title": "video_id",
//        "field_value": "579169d197f8155a7aed2a1b"
//        }
    }

    public func requestVideoDetail() {
        if let strId = self.strId {
            //            let videoAPI: SPLTVideoAPI = SPLTVideoAPI()
            //            videoAPI.getVideo(strId, completion: { (videoDict) in
            //                self.videoDict = videoDict
            //                self.mapFromVideoDict(videoDict)
            //                }, completionError: { (error) in
            //
            //            })
            SPLTVideoAPI().getVideo(strId, completion: { (videoDict) in
                // Video dict
                self.videoDict = videoDict
                self.mapFromVideoDict(videoDict)
                if let thumbPath = videoDict["thumb"] as? String {
                    self.thumb = thumbPath
                }
                
                self.delegate?.didUpdateVideo()
            }, completionError: { (error) in
                // Error
            })
        }
    }
    
    func updateVideoProgress() {
        if let strId = self.strId {
            
            SPLTVideoProgressAPI().getVideoProgress(strId, completion: { (responseDict) in
                if let point = responseDict["point"] as? Int {
                    self.progressPoint = point
                }
            }, completionError: { (error) in
                //print(error)
            })
        }
    }

    
    ////MARK: -
    ////MARK: - SPLTVideo Methods
    func loadFullVideo(_ completion: @escaping (_ videoDict: [String: AnyObject]) -> Void, completionError: @escaping (_ error: NSError) -> Void) {
        if let strVideoId = self.strId {
            self.loadPlaylistVideo({ (videoDict) in
                // success
                SPLTVideoProgressAPI().getVideoProgress(strVideoId, completion: { (responseDict) in
                    if let point = responseDict["point"] as? Int {
                        self.progressPoint = point
                    }
                    #if os(tvOS)
                        self.loadVideoAdTag(videoDict, completion: completion, completionError: completionError)
                    #else
                        completion(videoDict)
                    #endif
                }, completionError: { (error) in
                    // error while updating video progress, but success to video data call.
                    #if os(tvOS)
                        self.loadVideoAdTag(videoDict, completion: completion, completionError: completionError)
                    #else
                        completion(videoDict)
                    #endif
                })
            }) { (error) in
                // error
                completionError(error)
            }
        } else {
            completionError(NSError(domain: "SPLTVideo", code: 1, userInfo: nil))
        }
    }
    func loadVideoAdTag(_ videoDict: [String: AnyObject], completion: ((_ videoDict: [String: AnyObject]) -> Void)?, completionError: ((_ error: NSError) -> Void)?) {
        #if os(tvOS)
            if let strVideoId = self.strId {
                SPLTAdsAPI().getAdTagForVideo(strVideoId, width: 1920, height: 1080, completion: { (adTagsDict) in
                    // success
                    self.mapFromVideoAdTagDict(adTagsDict)
                    completion?(videoDict)
                }, completionError: { (error) in
                    // error.
                    completion?(videoDict)
                })
            }
        #endif
    }
    func loadPlaylistVideo(_ completion: @escaping (_ videoDict: [String: AnyObject]) -> Void, completionError: @escaping (_ error: NSError) -> Void) {
        if let strId = self.strId {
            self.spltVideoAPI = SPLTVideoAPI()
            self.spltVideoAPI?.getVideo(strId, completion: { (videoDict) in
                    // Video dict
                    self.videoDict = videoDict
                    self.mapFromVideoAPIDict(videoDict)
                    self.bVideoUpdated = true
                    completion(videoDict)
//                self.mapFromVideoDictionary(videoDict)
//                self.delegate?.didUpdateVideoData(videoDict)
                    self.spltVideoAPI = nil
                }, completionError: { (error) in
                    // Error
                    completionError(NSError(domain: " ", code: 1, userInfo: nil))
                    self.spltVideoAPI = nil
            })
        } else {
            completionError(NSError(domain: " ", code: 1, userInfo: nil))
        }
    }
    func cancelLoadFullVideo() {
        self.spltVideoAPI?.cancelRequest()
    }
    

    ////MARK: -
    ////MARK: - SPLTVideo Methods
    func mapFromCustomPlaylistChannelVideoDict(_ customPlaylistChannelVideoDict: [String: AnyObject]) {
        //        {
        //            "_id": "586723f397f815b15161b53e",
        //            "company_id": "57fe8fe399f815e309dbc2f4",
        //            "title": "Mental Issue Problems",
        //            "seriestitle": "Sheriffs El Dorado County",
        //            "thumb": "586729b097f8150a5f61b53b",
        //            "duration": 2303,
        //            "point": 1162
        //        }
        
        if let strId = customPlaylistChannelVideoDict["_id"] as? String {
            self.strId = strId
        }
        if let strComapnyId = customPlaylistChannelVideoDict["company_id"] as? String {
            self.strComapnyId = strComapnyId
        }
        if let strTitle = customPlaylistChannelVideoDict["title"] as? String {
            self.strTitle = strTitle
        }
        if let strSeriesTitle = customPlaylistChannelVideoDict["seriestitle"] as? String {
            self.strSeriesTitle = strSeriesTitle
        }
        
        if let thumbId = customPlaylistChannelVideoDict["thumb"] as? String {
            if (thumbId.range(of: "http:") == nil) && (thumbId.range(of: "https:") == nil) {
                self.thumb = SPLTFullPathRouter.imageFullPath(thumbId).URLString
            } else {
                self.thumb = thumbId
            }
        }

        
        if let strDuration = customPlaylistChannelVideoDict["duration"] as? String {
            if let fDuration = Float(strDuration) {
                if !fDuration.isNaN {
                    self.iDuration = Int(fDuration)
                }
            }
        } else if let fDuration = customPlaylistChannelVideoDict["duration"] as? Float {
            if !fDuration.isNaN {
                self.iDuration = Int(fDuration)
            }
        }

        if let point = customPlaylistChannelVideoDict["point"] as? Int {
            self.progressPoint = point
        }

    }

    ////MARK: -
    ////MARK: - SPLTVideo progress view Methods
    func videoProgressForProgressView() -> Float? {
//        if let video = self.video {
            let iVideoDuration = self.iDuration
            if let iProgressPoint = self.progressPoint {
                if iProgressPoint < SPLTVideo.DURATION_THRESHOLD {
                    return nil // if video duration is less than thresshold of 30 sec. no need to show progress bar.
                }
                let fVideoDuration = Float(iVideoDuration)
                let fProgressPoint = Float(iProgressPoint)
                let fProgress = fProgressPoint/fVideoDuration
                return fProgress
            }
//        }
        return nil
    }


    ////MARK: -
    ////MARK: - SPLTVideo get Ad Tag Methods
    func getAdTagForPreRoll(_ strOffsetToCompare: String) -> String? {
        #if USE_PLAY2_ROUTE
            if let adsTagsDict = self.adsTagsDict {
                if let strPreAdTag = adsTagsDict["adTagPre"] as? String {
                    let strCompleteAdTagUrl = K10Utility.completeUrlFor(strPreAdTag)
                    return strCompleteAdTagUrl
                }
            }
        #else
//            if let iosads_breaksDict = self.iosads_breaksDict {
//                for key in iosads_breaksDict.keys {
//                    if let adbreakDict = iosads_breaksDict[key] as? [String: AnyObject] {
//                        if let strOffset = adbreakDict["offset"] as? String, strOffset == strOffsetToCompare {
//                            if let tagsArray = adbreakDict["tag"] as? [String], tagsArray.count > 0 {
//                                return tagsArray[0]
//                            }
//                        }
//                    }
//                }
//            }
        #endif
        return nil
    }
    
    func getAdTagForMidRoll(_ strOffsetToCompare: String) -> String? {
        #if USE_PLAY2_ROUTE
            if let adsTagsDict = self.adsTagsDict {
                if let strMidAdTag = adsTagsDict["adTagMid"] as? String {
                    let strCompleteAdTagUrl = K10Utility.completeUrlFor(strMidAdTag)
                    return strCompleteAdTagUrl
                }
            }
        #else
//            if let iosads_breaksDict = self.iosads_breaksDict {
//                for key in iosads_breaksDict.keys {
//                    if let adbreakDict = iosads_breaksDict[key] as? [String: AnyObject] {
//                        if let strOffset = adbreakDict["offset"] as? String, strOffset == strOffsetToCompare {
//                            if let tagsArray = adbreakDict["tag"] as? [String], tagsArray.count > 0 {
//                                return tagsArray[0]
//                            }
//                        }
//                    }
//                }
//            }
        #endif
        return nil
    }
    func getAdTagForPostRoll(_ strOffsetToCompare: String) -> String? {
        #if USE_PLAY2_ROUTE
            if let adsTagsDict = self.adsTagsDict {
                if let strPostAdTag = adsTagsDict["adTagPost"] as? String {
                    let strCompleteAdTagUrl = K10Utility.completeUrlFor(strPostAdTag)
                    return strCompleteAdTagUrl
                }
            }
        #else
//            if let iosads_breaksDict = self.iosads_breaksDict {
//                for key in iosads_breaksDict.keys {
//                    if let adbreakDict = iosads_breaksDict[key] as? [String: AnyObject] {
//                        if let strOffset = adbreakDict["offset"] as? String, strOffset == strOffsetToCompare {
//                            if let tagsArray = adbreakDict["tag"] as? [String], tagsArray.count > 0 {
//                                return tagsArray[0]
//                            }
//                        }
//                    }
//                }
//            }
        #endif
        return nil
    }


    //MARK: -
    //MARK: - Ads Configuration methods
    //MARK: - extension Video Ad tag mapping
    fileprivate func setUpAdsFromAdDictionary(_ adsDict: [String: AnyObject]) {
        if let overAd = adsDict["over"] as? String {
            if overAd == "no" {
                self.adType_over = false
            } else if overAd == "yes" {
                self.adType_over = true
            }
        }
        if let preAd = adsDict["pre"] as? String {
            if preAd == "no" {
                self.adType_pre = false
            } else if preAd == "yes" {
                self.adType_pre = true
            }
        }
        if let postAd = adsDict["post"] as? String {
            if postAd == "no" {
                self.adType_post = false
            } else if postAd == "yes" {
                self.adType_post = true
            }
        }
        if let midAd = adsDict["mid"] as? String {
            if midAd == "no" {
                self.adType_mid = false
            } else if midAd == "yes" {
                self.adType_mid = true
                self.setUpMidAdsDictionary(adsDict as NSDictionary)
            }
        }
    }
    fileprivate func setUpMidAdsDictionary(_ adsDict: NSDictionary) {
//        self.midRollAdBreaks.removeAll()
        self.midRollAdBreaksDict.removeAll()
        if let midAdOffsets = adsDict["offsets"] as? NSDictionary {
            if let midAdsLinearArray = midAdOffsets["linear"] as? [String] {
                for strLinearValue: String in midAdsLinearArray {
                    if let dLinearValue = Double(strLinearValue) {
                        let iLinearValue = Int(dLinearValue)
                        // Time : status   -- yes for ad shown, no for ad not yet shown.
                        var dict: [String: Any] = ["linear":iLinearValue, "shown": false]
                        self.midRollAdBreaksDict.append(dict)
                        //                        self.midRollAdTimeDict["Time_\(iLinearValue)"] = "no"
                    }
                }
            }
        }
    }

    func shouldShowMidRollAtTime(_ iCurrentTime: Int) -> Bool {
        var iMaxAdBreakInt = -1
        var iSelectedAdBreak = -1
        //var adBreakDict: [String: Any] = [:]
        for (index,midRollAdBreakDict) in self.midRollAdBreaksDict.enumerated() {
            if let iMidRollAdBreakPoint = self.midRollAdBreaksDict[index]["linear"] as? Int {
                if (iMidRollAdBreakPoint < iCurrentTime) {
                    if (iMaxAdBreakInt == -1 || iMaxAdBreakInt < iMidRollAdBreakPoint) {
                        if let bShown = self.midRollAdBreaksDict[index]["shown"] as? Bool, bShown == false {
                            iMaxAdBreakInt = iMidRollAdBreakPoint
                            iSelectedAdBreak = index
                        }
                        //adBreakDict = midRollAdBreakDict
                    }
                }
            }
        }
        if (iSelectedAdBreak != -1 && iMaxAdBreakInt != -1) {
            if let bShown = self.midRollAdBreaksDict[iSelectedAdBreak]["shown"] as? Bool, bShown == false {
                self.midRollAdBreaksDict[iSelectedAdBreak]["shown"] = true
                return true
            }
        }
        //self.midRollAdBreaksDict
        return false
    }
    
    func mapFromVideoAdTagDict(_ adTagsDict: [String: AnyObject]) {
        self.adsTagsDict = adTagsDict
    }
}

















