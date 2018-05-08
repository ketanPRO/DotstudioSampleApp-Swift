//
//  SPLTChannel.swift
//  DotstudioPRO
//
//  Created by ketan on 07/04/16.
//  Copyright © 2016 ___DotStudioz___. All rights reserved.
//

import Foundation

open class SPLTChannel: NSObject {
    
//    var delegate: SPLTCategoryDelegate?
    var channelDict: [String: AnyObject] = [:] {
        didSet {

        }
    }
    
    var strCategorySlug: String?
    var strId: String?
    var strDescription: String?
    var company: String?
    var spotlight_company_id: String?
    var strTitle: String?
    var strPath: String?
    var strSlug: String?
    @objc dynamic var poster: String?
    var spotlight_poster: String?
    var videos_thumb: String?
    var channel_url: String?
    
    var strChannelInfo: String?
    
    var isLeanChannelLoaded: Bool = false
    var isPartialChannelLoaded: Bool = false
    var isFullChannelLoaded: Bool = false
    
    #if os(iOS)
        var mutableAttributedStringChannelInfo: NSMutableAttributedString?
    #endif

    override init() {
        super.init()
    }
    init(channelDict: [String: AnyObject]) {
        super.init()
        
        self.channelDict = channelDict
        self.mapFromChannelDict(channelDict)
    }
    
    func mapFromChannelDict(_ channelDict: [String: AnyObject]) {
        if let strId = channelDict["_id"] as? String {
            self.strId = strId
        }
        if let strDescription = channelDict["description"] as? String {
            self.strDescription = strDescription
        }
        if let strCompany = channelDict["company"] as? String {
            self.company = strCompany
        }
        if let spotlight_company_id = channelDict["spotlight_company_id"] as? String {
            self.spotlight_company_id = spotlight_company_id
        }
        if let strTitle = channelDict["title"] as? String {
            self.strTitle = strTitle
        }
        if let strPath = channelDict["path"] as? String {
            self.strPath = strPath
        }
        if let strSlug = channelDict["slug"] as? String {
            self.strSlug = strSlug
        }
        if let poster = channelDict["poster"] as? String {
            self.poster = poster
        }
        if let spotlight_poster = channelDict["spotlight_poster"] as? String {
            self.spotlight_poster = spotlight_poster
        }
        if let videos_thumb = channelDict["videos_thumb"] as? String {
            self.videos_thumb = videos_thumb
        }
        if let channel_url = channelDict["channel_url"] as? String {
            self.channel_url = channel_url
        }

        self.updateChannelInfo()
    }
    
    func updateChannelInfo() {
        var strChannelInfo = ""
        if let strCategory = self.channelDict["category"] as? String {
            strChannelInfo = "\(strCategory) | "
        }
        if let strYear = self.channelDict["year"] as? String {
            strChannelInfo += "\(strYear) | "
        }
        if let strRating = self.channelDict["rating"] as? String {
            strChannelInfo += "\(strRating) | "
        }
        if let strLanguage = self.channelDict["language"] as? String {
            strChannelInfo += "\(strLanguage) | "
        }
        if let strCountry = self.channelDict["country"] as? String {
            strChannelInfo += "\(strCountry) | "
        }
        
        let iStringLengthBeforeCompanyName: Int = strChannelInfo.characters.count
        var strCompanyName: String?
        if let strCompany = self.company {
            strChannelInfo += "\(strCompany.uppercased())"
            strCompanyName = strCompany
        }
        self.strChannelInfo = strChannelInfo

//        #if os(iOS)
//            let spotlightFont: UIFont = UIFont(name: "Montserrat-Regular", size: 18.0)!
//            let myMutableString: NSMutableAttributedString = NSMutableAttributedString(string: strChannelInfo, attributes: [NSAttributedStringKey.font:spotlightFont])
//            if let fontColor = K10Theme.fontColor {
//                myMutableString.addAttribute(NSAttributedStringKey.foregroundColor, value: fontColor, range: NSMakeRange(0, strChannelInfo.characters.count))
//            }
//
//            if (strCompanyName != nil) {
//                let iStringLengthAfterCompanyName: Int = strChannelInfo.characters.count
//                let range: NSRange = NSMakeRange(iStringLengthBeforeCompanyName, (iStringLengthAfterCompanyName - iStringLengthBeforeCompanyName))
//    //            let spotlightGreenColor = UIColor(red: 47.0/255.0, green: 137.0/255.0, blue: 80.0/255.0, alpha: 1.0)
//                if let corporateColor = K10Theme.corporateColor {
//                    myMutableString.addAttribute(NSAttributedStringKey.foregroundColor, value: corporateColor, range: range)
//                }
//            } else {
//                //                    featuredCellView?.labelChannelInfo.text = strChannelInfo
//            }
//            self.mutableAttributedStringChannelInfo = myMutableString
//        #endif
    }
    
    func isChannelVideosUpdated() -> Bool {
        return false
    }
    func loadChannelVideos(_ completion: @escaping (_ bSuccess: Bool) -> Void, completionError: @escaping (_ error: NSError) -> Void) {
        
    }
    func getVideoProgressForChannelVideos(_ completion: @escaping (_ responseDictArray: [[String: AnyObject]]) -> Void, completionError: @escaping (_ error: NSError) -> Void) {
    }

    ////MARK: -
    ////MARK: - SPLTChannel Methods
    func loadFullChannel(_ completion: ((_ channelDict: [String: AnyObject]) -> Void)?, completionError: ((_ error: NSError) -> Void)?) {
        if let strSlug = self.strSlug {
            if let strCategorySlug = self.strCategorySlug {
                let channelAPI: SPLTChannelAPI = SPLTChannelAPI()
//                channelAPI.delegate = self
//                channelAPI.getCategoryChannel(strCategorySlug, strChannelSlug: strSlug, completion: completion, completionError: completionError)
                channelAPI.getCategoryChannel(strCategorySlug, strChannelSlug: strSlug, completion: { (channelDict) in
                    self.channelDict = channelDict
                    self.mapFromChannelDict(channelDict)
                    self.loadChannelVideoProgress({ (responseDictVideoProgress) in
                        // success
                        completion?(channelDict)
                    }, completionError: { (error) in
                        // error
                        completion?(channelDict)
                    })
                    self.isFullChannelLoaded = true
//                    completion?(channelDict)
                }, completionError: { (error) in
                    completionError?(error)
                })
            } else {
                let channelAPI: SPLTChannelAPI = SPLTChannelAPI()
//                channelAPI.delegate = self
//                channelAPI.getChannel(strSlug, completion: completion, completionError: completionError)
                channelAPI.getChannel(strSlug, completion: { (channelDict) in
                    self.channelDict = channelDict
                    self.mapFromChannelDict(channelDict)
                    self.loadChannelVideoProgress({ (responseDictVideoProgress) in
                        // success
                        completion?(channelDict)
                    }, completionError: { (error) in
                        // error
                        completion?(channelDict)
                    })
                    self.isFullChannelLoaded = true
                    //completion?(channelDict)
                }, completionError: { (error) in
                    completionError?(error)
                })
            }
        } else {
            completionError?(NSError(domain: "SPLTChannel", code: 1, userInfo: ["message":"slug not found"]))
        }
    }
    func loadPartialChannel(_ completionChannel: ((_ channelDict: [String: AnyObject]) -> Void)?, completionErrorChannel: ((_ error: NSError) -> Void)?) {
        if let strSlug = self.strSlug {
            
            let channelAPI: SPLTChannelAPI = SPLTChannelAPI()
//            channelAPI.delegate = self
            channelAPI.getPartialChannel(strSlug, completion: { (channelDict) in
                //comple
                self.isPartialChannelLoaded = true
                completionChannel?(channelDict)
            }, completionError: { (error) in
                // error while getting partial channel.
                completionErrorChannel?(error)
            })
            
//            let channelAPI: SPLTChannelAPI = SPLTChannelAPI()
//            channelAPI.getChannel(strSlug, completion: completion, completionError: completionError)
        } else {
            completionErrorChannel?(NSError(domain: "SPLTChannel", code: 1, userInfo: ["message":"slug not found"]))
        }
    }

    func loadChannelVideoProgress(_ completion: ((_ channelDict: [[String: AnyObject]]) -> Void)?, completionError: ((_ error: NSError) -> Void)?) {
        // load Video Progress
            completion?([])
    }

    ////MARK: -
    ////MARK: - SPLTChannel Methods
    public func didReceiveChannel(_ spotlightChannels_: [String : AnyObject]) {
        self.channelDict = spotlightChannels_
        self.mapFromChannelDict(channelDict)
    }
    public func didFailedChannelAPICall() {
        
    }

    ////MARK: -
    ////MARK: - static open Methods
    open class func getChannelFromChannelDict(_ channelDict: [String: AnyObject]) -> SPLTChannel? {
        var spltChannel: SPLTChannel?
        if let childChannels = channelDict["childchannels"] as? [AnyObject], childChannels.count > 0 {
            // Create SPLTMultiLevelChannel
            spltChannel = SPLTMultiLevelChannel(channelDict: channelDict)
        } else if let strPlaylistId = channelDict["playlist_id"] as? String, strPlaylistId != "" {
            spltChannel = SPLTPlaylistChannel(channelDict: channelDict)
        } else if let strVideoId = channelDict["video_id"] as? String, strVideoId != ""  {
            // Create single video channel
            spltChannel = SPLTVideoChannel(channelDict: channelDict)
        } else if let playlist = channelDict["playlist"] as? [[String: AnyObject]], playlist.count > 0 {
            // Create SPLTPlaylistChannel
            spltChannel = SPLTPlaylistChannel(channelDict: channelDict)
//        } else if (channelDict["video"] as? [String: AnyObject]) != nil {
//            // Create single video channel
//            spltChannel = SPLTVideoChannel(channelDict: channelDict)
        } else {
            // error. // could be Multilevel channel
            spltChannel = SPLTMultiLevelChannel(channelDict: channelDict)
        }
        return spltChannel

    }
}





