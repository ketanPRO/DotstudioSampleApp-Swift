//
//  SPLTCategory.swift
//  DotstudioPRO
//
//  Created by ketan on 07/04/16.
//  Copyright © 2016 ___DotStudioz___. All rights reserved.
//

import Foundation

@objc protocol SPLTCategoryDelegate {
    @objc optional func didUpdateCategoryChannels()
    @objc optional func didUpdateCategoryChannelsForCategory(_ category: SPLTCategory)
}

open class SPLTCategory: NSObject { //, DTSZChannelAPIDelegate {

    var delegate: SPLTCategoryDelegate?
//    var genericTableViewCellObjectDelegate: TVOSGenericTableViewCellObjectDelegate?
//    {
//        get {
//            return self.genericFeaturedTableViewCellObjectDelegate
//        }
//        set {
//            //self.genericFeaturedTableViewCellObjectDelegate = genericFeaturedTableViewCellObjectDelegate
//        }
//    }
    var categoryDict: [String: AnyObject] = [:] {
        didSet {
        }
    }
    var channelsDict: [[String: AnyObject]] = [[:]] {
        didSet {
            for channelDict in channelsDict {
                
                if let spltChannel = SPLTChannel.getChannelFromChannelDict(channelDict) {
                    spltChannel.strCategorySlug = self.strSlug
                    spltChannel.isLeanChannelLoaded = true
                    self.channels.append(spltChannel)
                }
                
            }
            self.delegate?.didUpdateCategoryChannels?()
            self.delegate?.didUpdateCategoryChannelsForCategory?(self)
            if let strSlug = self.strSlug {
                let strUniqueCategoryNotification = SPLTConstants.SPLTCategory_DidUpdateCategoryChannels + strSlug
                NotificationCenter.default.post(name: Notification.Name(rawValue: strUniqueCategoryNotification), object: nil)
            }
//            self.genericTableViewCellObjectDelegate?.didLoadSubData()
        }
    }
    var isCategoryChannelsLeanDataLoaded: Bool = false
    var channels: [SPLTChannel] = []

    var bHomePage: Bool = false
    var bMenu: Bool = false
    var strId: String?
    var strName: String?
    var strCategoryChannelPath: String?
    var strSlug: String?
    var weight: Int = 0
    
    override init() {
        super.init()
    }
    init(categoryDict: [String: AnyObject]) {
        super.init()
        self.categoryDict = categoryDict
        self.mapFromCategoryDict(categoryDict)
    }
    
    func mapFromCategoryDict(_ categoryDict: [String: AnyObject]) {
        if let bHomePage = categoryDict["homepage"] as? Bool {
            self.bHomePage = bHomePage
        }
        if let bMenu = categoryDict["menu"] as? Bool {
            self.bMenu = bMenu
        }
        if let strId = categoryDict["_id"] as? String {
            self.strId = strId
        }
        if let strName = categoryDict["name"] as? String {
            self.strName = strName
        }
        if let strCategoryChannelPath = categoryDict["channels"] as? String {
            self.strCategoryChannelPath = strCategoryChannelPath
        }
        if let strSlug = categoryDict["slug"] as? String {
            self.strSlug = strSlug
        }
        if let weight = categoryDict["weight"] as? Int {
            self.weight = weight
        }
    }
    
    class func getFirstCategoryWithMatchingSlug(_ categories: [SPLTCategory], strSlug: String) -> SPLTCategory? {
        let filteredCategories = categories.filter { (category) -> Bool in
            if category.strSlug == strSlug {
                return true
            }
            return false
        }
        if let filteredCategory = filteredCategories.first {
            return filteredCategory
        }
        return nil
    }
}


////MARK: -
////MARK: - Category Methods
extension SPLTCategory {
    func loadCategoryChannels(completion: @escaping (_ categoryChannels: [[String: AnyObject]]) -> Void, completionError: @escaping (_ error: NSError) -> Void) {
        
        if let strSlug = self.strSlug {
            
            var bLeanData: Bool = true
            #if APP_CRAZY8S || MOVIEATTIC
                bLeanData = false
            #endif
            
            SPLTChannelsAPI().getChannelsOfCategory(bLeanData, strCategorySlug: strSlug, completion: { (categoryChannels) in
                    self.channelsDict = categoryChannels
                    completion(categoryChannels)
                }, completionError: { (error) in
                    print("error while fetching channels of category.")
                    completionError(error)
            })
        }
        
//        if let strCategoryChannelPath = self.strCategoryChannelPath {
//            SPLTAPI().getJSONResponse(strCategoryChannelPath, completion: { (dictionary) in
//                // Success
//                if let bValue = dictionary["success"] as? Bool {
//                    if bValue == true {
//                        if let channelsDict = dictionary["channels"] as? [[String: AnyObject]] {
//                            self.channelsDict = channelsDict
//                        }
//                    }
//                }
//            }) { (error) in
//                // Error
//            }
//        }
    }
}



