//
//  SPLTCompanyData.swift
//  DotstudioPRO
//
//  Created by ketan on 07/04/16.
//  Copyright © 2016 ___DotStudioz___. All rights reserved.
//

import Foundation

public protocol SPLTCompanyDataDelegate {
    func didUpdateCategories()
    func didUpdateChannels()
}

class SPLTCompanyData: NSObject {
    
    static let sharedInstance = SPLTCompanyData()
    var bUseCustomCategories: Bool = false
    override init() {
        super.init()
        NotificationCenter.default.addObserver(self, selector: #selector(SPLTCompanyData.didCompleteLogin), name: NSNotification.Name.SPLT_LOGIN_COMPLETED, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(SPLTCompanyData.didCompleteLogout), name: NSNotification.Name.SPLT_LOGOUT_COMPLETED, object: nil)
    }
    var delegate: SPLTCompanyDataDelegate?
    var categoriesDict: [[String: AnyObject]] = [[:]] {
        didSet {
//            self.categories = []
//            for categoryDict in categoriesDict {
//                let spltCategory: SPLTCategory = SPLTCategory(categoryDict: categoryDict)
//                spltCategory.loadCategoryChannels(completion: { (dictCategoryChannel) in
//                    // dict category channels loaded.
//                }, completionError: { (error) in
//                    // error while loading category channels.
//                })
//                
//                #if USE_MORE_LIKE_THIS_RECOMMENDATION
//                    if spltCategory.strSlug == "more-like-this" {
//                        self.categoryMoreLikeThis = spltCategory
//                        self.spltRecommandedData = SPLTRecommandedData(categoryMoreLikeThis: spltCategory)
//                        self.categoryMoreLikeThis?.delegate = self.spltRecommandedData!
//                    }
//                #endif
//                self.categories.append(spltCategory)
//            }
//            self.delegate?.didUpdateCategories()
//            NotificationCenter.default.post(name: Notification.Name(rawValue: SPLTConstants.SPLTCompanyData_DidUpdateCategories), object: nil)
        }
    }
    var categories: [SPLTCategory] = []
    var customCategories: [SPLTCustomCategory] = []
    var categoryMoreLikeThis: SPLTCategory?
    var spltRecommandedData: SPLTRecommandedData?
    
    var channelsDict: [[String: AnyObject]] = [[:]] {
        didSet {
            self.channels.removeAll()
            for channelDict in channelsDict {
                var spltChannel: SPLTChannel?
                if let childChannels = channelDict["childchannels"] as? [AnyObject], childChannels.count > 0 {
                    // Create SPLTMultiLevelChannel
                } else if (channelDict["playlist_id"] as? String) != nil {
                    spltChannel = SPLTPlaylistChannel(channelDict: channelDict)
                } else if let playlist = channelDict["playlist"] as? [[String: AnyObject]], playlist.count > 0 {
                    // Create SPLTPlaylistChannel
                    spltChannel = SPLTPlaylistChannel(channelDict: channelDict)
//                } else if let videoDict = channelDict["video"] as? [String: AnyObject] {
//                    // Create single video channel
                }
                if (spltChannel != nil) {
                    self.channels.append(spltChannel!)
                }
            }
            self.delegate?.didUpdateChannels()
        }
    }
    var channels: [SPLTChannel] = []

    
    var featuredChannelDict: [String: AnyObject] = [:] {
        didSet {
            if let childChannels = featuredChannelDict["childchannels"] as? [AnyObject], childChannels.count > 0 {
                // Create SPLTMultiLevelChannel
            } else if (featuredChannelDict["playlist_id"] as? String) != nil {
                self.featuredChannel = SPLTPlaylistChannel(channelDict: featuredChannelDict)
            } else if let playlist = featuredChannelDict["playlist"] as? [[String: AnyObject]], playlist.count > 0 {
                // Create SPLTPlaylistChannel
                self.featuredChannel = SPLTPlaylistChannel(channelDict: featuredChannelDict)
//            } else if let videoDict = featuredChannelDict["video"] as? [String: AnyObject] {
//                // Create single video channel
            }
        }
    }
    var featuredChannel: SPLTPlaylistChannel? {
        didSet {
//            self.delegate?.didUpdateTopShelfChannel()
        }
    }
    
    
    
}

//MARK: - Get Categories
extension SPLTCompanyData {
    func removeAllCategories() {
        self.categories.removeAll()
        self.customCategories.removeAll()
        self.delegate?.didUpdateCategories()
        NotificationCenter.default.post(name: Notification.Name(rawValue: SPLTConstants.SPLTCompanyData_DidUpdateCategories), object: nil)
    }
    func getCategories() {
        SPLTCategoriesAPI().getCategories({ (categoriesDict) in
                // received Categories
            
                let appleCategoriesDict = categoriesDict.filter { (category) -> Bool in
                    #if os(tvOS)
                        if let platformsDicts = category["platforms"] as? [[String: AnyObject]], platformsDicts.count > 0 {
                            if let bSupportsAppleTV = platformsDicts[0]["apple_tv"] as? Bool {
                                if bSupportsAppleTV == true {
                                    return true
                                }
                            }
                            if let strSupportsAppleTV = platformsDicts[0]["apple_tv"] as? String {
                                if strSupportsAppleTV == "true" {
                                    return true
                                }
                            }
                        }
                    #else
                        if let platformsDicts = category["platforms"] as? [[String: AnyObject]], platformsDicts.count > 0 {
                            if let bSupportsAppleTV = platformsDicts[0]["ios"] as? Bool {
                                if bSupportsAppleTV == true {
                                    return true
                                }
                            }
                            if let strSupportsAppleTV = platformsDicts[0]["ios"] as? String {
                                if strSupportsAppleTV == "true" {
                                    return true
                                }
                            }
                        }
                    #endif
                    return false
                }

                self.categoriesDict = appleCategoriesDict
                self.setCategories()
                self.loadCategories()
            
            }) { (error) in
                // Error while receiving categories...
        }
        
        self.getCustomCategoriesIfRequired()
    }
    
    func setCategories() {
        self.categories = []
        for categoryDict in categoriesDict {
            let spltCategory: SPLTCategory = SPLTCategory(categoryDict: categoryDict)
            #if USE_MORE_LIKE_THIS_RECOMMENDATION
                if spltCategory.strSlug == "more-like-this" {
                    self.categoryMoreLikeThis = spltCategory
                    self.spltRecommandedData = SPLTRecommandedData(categoryMoreLikeThis: spltCategory)
                    self.categoryMoreLikeThis?.delegate = self.spltRecommandedData!
                }
            #endif
            self.categories.append(spltCategory)
        }
        self.AddCustomCategoriesToMainSPLTCategoriesList()
        self.delegate?.didUpdateCategories()
        NotificationCenter.default.post(name: Notification.Name(rawValue: SPLTConstants.SPLTCompanyData_DidUpdateCategories), object: nil)
    }
    func loadCategories() {
        
        var isAnyCategoryLeanDataPending: Bool = false
        for category in self.categories {
            if category is SPLTCustomCategory {
                continue
            }
            if category.isCategoryChannelsLeanDataLoaded {
                continue
            } else {
                category.loadCategoryChannels(completion: { (dictCategoryChannel) in
                    // dict category channels loaded.
                    category.isCategoryChannelsLeanDataLoaded = true
                    self.loadCategories()
                }, completionError: { (error) in
                    // error while loading category channels.
                    category.isCategoryChannelsLeanDataLoaded = true
                    self.loadCategories()
                })
                isAnyCategoryLeanDataPending = true
                return
            }
        }
        
//        self.categories = []
//        for categoryDict in categoriesDict {
//            let spltCategory: SPLTCategory = SPLTCategory(categoryDict: categoryDict)
//            spltCategory.loadCategoryChannels(completion: { (dictCategoryChannel) in
//                // dict category channels loaded.
//            }, completionError: { (error) in
//                // error while loading category channels.
//            })
//            #if USE_MORE_LIKE_THIS_RECOMMENDATION
//                if spltCategory.strSlug == "more-like-this" {
//                    self.categoryMoreLikeThis = spltCategory
//                    self.spltRecommandedData = SPLTRecommandedData(categoryMoreLikeThis: spltCategory)
//                    self.categoryMoreLikeThis?.delegate = self.spltRecommandedData!
//                }
//            #endif
//            self.categories.append(spltCategory)
//        }
//        self.delegate?.didUpdateCategories()
//        NotificationCenter.default.post(name: Notification.Name(rawValue: SPLTConstants.SPLTCompanyData_DidUpdateCategories), object: nil)

    }
    
    func getChannels() {
        
//        SPLTChannelsAPI().getChannels({ (channelsDict) in
//                self.channelsDict = channelsDict
//            }) { (error) in
//                // Error while receiving channels
//        }
        
        
        SPLTChannelsAPI().getChannelsOfCategory(strCategorySlug: "channels", completion: { (categoryChannels) in
            if categoryChannels.count > 0 {
                self.channelsDict = categoryChannels
            }
            }, completionError: { (error) in
                // Error while receiving featured channel
        })

    }
    
    //MARK: - GET Featured Channels list
    func getTopShelfChannels(_ completion: @escaping (_ featuredChannel: SPLTPlaylistChannel?) -> Void) {
        SPLTChannelsAPI().getChannelsOfCategory(strCategorySlug: "top-shelf", completion: { (categoryChannels) in
            if categoryChannels.count > 0 {
                self.featuredChannelDict = categoryChannels[0]
                completion(self.featuredChannel)
            }
            }, completionError: { (error) in
                // Error while receiving featured channel
        })
        
    }


//    func getTopShelfChannels() {
//        SPLTChannelsAPI().getChannelsOfCategory(strCategorySlug: "featured", completion: { (categoryChannels) in
//            <#code#>
//            }, completionError: { (error) in
//                // Error while receiving featured channel
//        })
//            
//            .getChannels({ (channelsDict) in
//            self.channelsDict = channelsDict
//        }) { (error) in
//            // Error while receiving channels
//        }
//    }
}

////MARK: -
////MARK: - extension SPLTVideoAPIDelegate
//extension SPLTCompanyData: SPLTVideoAPIDelegate {
//    func didReceiveVideoData(infoDict: [String: AnyObject]) {
////        self.mapFromVideoDictionary(infoDict)
////        self.delegate?.didUpdateVideoData(infoDict)
//    }
//    func didFailedVideoAPICall() {
//        //        self.delegate?.didFailedChannelAPICall()
//    }
//    //    func didReceiveChannel(spotlightChannel_: [String : AnyObject]) {
//    //        self.mapFromVideoDictionary(spotlightChannel_)
//    ////        self.delegate?.didUpdateChannelData(spotlightChannel_)
//    //    }
//    //    func didFailedChannelAPICall() {
//    //        //        self.delegate?.didFailedChannelAPICall()
//    //    }
//}


//MARK: -
//MARK: - Get custom Categories
extension SPLTCompanyData {
    func AddCustomCategoriesToMainSPLTCategoriesList() {
        var allCategories = self.categories
        var filteredAllCategories = allCategories.filter { (spltCategory) -> Bool in
            if spltCategory is SPLTCustomCategory {
                return false
            }
            return true
        }
        for customCategory in self.customCategories {
            if customCategory.enumSPLTCustomCategoryType == .continueWatching {
                filteredAllCategories.insert(customCategory, at: 0)
            } else if customCategory.enumSPLTCustomCategoryType == .watchAgain {
                filteredAllCategories.append(customCategory)
            }
        }
        self.categories = filteredAllCategories
    }
    func setCustomCategoriesFromDict(_ customCategoriesDict: [String: AnyObject]) {
        self.customCategories.removeAll()
        if let arrayCategoriesDict = customCategoriesDict["continue-watching"] as? [[String: AnyObject]], arrayCategoriesDict.count > 0 {
            let continueWatchingCategory = SPLTCustomCategory(.continueWatching, customChannelVideosArray: arrayCategoriesDict)
            continueWatchingCategory.isCategoryChannelsLeanDataLoaded = true
            self.customCategories.append(continueWatchingCategory)
        }
        if let arrayCategoriesDict = customCategoriesDict["watch-again"] as? [[String: AnyObject]], arrayCategoriesDict.count > 0 {
            let watchAgainCategory = SPLTCustomCategory(.watchAgain, customChannelVideosArray: arrayCategoriesDict)
            watchAgainCategory.isCategoryChannelsLeanDataLoaded = true
            self.customCategories.append(watchAgainCategory)
        }
    }
    func getCustomCategoriesIfRequired() {
        if self.bUseCustomCategories {
            self.getCustomCategories()
        }
    }
    internal func getCustomCategories() {
        if SPLTRouter.strClientToken == nil {
            return
        }
        SPLTResumptionAPI().getResumptionVideos({ (responseDict) in
            // success
            self.setCustomCategoriesFromDict(responseDict)
            self.AddCustomCategoriesToMainSPLTCategoriesList()
            self.delegate?.didUpdateCategories()
            NotificationCenter.default.post(name: Notification.Name(rawValue: SPLTConstants.SPLTCompanyData_DidUpdateCategories), object: nil)

        }) { (error) in
            // error
        }
    }
}

//MARK: -
//MARK: - Get Notification methods
extension SPLTCompanyData {
    @objc func didCompleteLogin() {
        self.removeAllCategories()
        self.getCategories()
    }
    @objc func didCompleteLogout() {
        self.removeAllCategories()
        self.getCategories()
    }
}












