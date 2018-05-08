//
//  SPLTCategories.swift
//  DotstudioPRO
//
//  Created by ketan on 17/02/16.
//  Copyright © 2016 ___DotStudioz___. All rights reserved.
//

import Foundation
import Alamofire

public protocol SPLTCategoriesAPIDelegate: NSObjectProtocol {
    func didReceiveCategories(_ spotlightCategories_: [[String: AnyObject]])
    func didFailedCategoriesAPICall()
}

open class SPLTCategoriesAPI {
    
    open var delegate: SPLTCategoriesAPIDelegate?
    
    public init() {
        
    }
    
    open func regenerateAccessTokenAndGetCategories() {
        SPLTTokenAPI().getToken { (strToken) -> Void in
            self.getCategories()
        }
    }
    
    open func getCategories() {
        SPLTBaseAPI.sessionManager.request(SPLTRouter.categories, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).validate().responseJSON { (response) in
            if (response.result.value != nil) {
                if let infoDict = response.result.value as? [String: AnyObject] {
                    if let categoriesDict = infoDict["categories"] as? [[String: AnyObject]] {
                        self.delegate?.didReceiveCategories(categoriesDict)
                        return
                    }
                }
            }
            self.delegate?.didFailedCategoriesAPICall()
        }
        
    }
    
    
    
    
    // With Block methods
    open func regenerateAccessTokenAndGetCategories(_ completion: @escaping (_ categoriesDict: [[String: AnyObject]]) -> Void, completionError: @escaping (_ error: NSError) -> Void) {
        SPLTTokenAPI().getToken { (strToken) -> Void in
            self.getCategories(completion, completionError: completionError)
        }
    }
    
    open func getCategories(_ completion: @escaping (_ categoriesDict: [[String: AnyObject]]) -> Void, completionError: @escaping (_ error: NSError) -> Void) {
        
        if (SPLTRouter.strAccessToken == nil) {
            self.regenerateAccessTokenAndGetCategories(completion, completionError: completionError)
            return
        }
         SPLTBaseAPI.sessionManager.request(SPLTRouter.categories, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).validate().responseJSON { (response) in
                    if (response.result.value != nil) {
                        if let infoDict = response.result.value as? [String: AnyObject] {
                            if let categoriesDict = infoDict["categories"] as? [[String: AnyObject]] {
//                                self.delegate?.didReceiveCategories(categoriesDict)
                                completion(categoriesDict)
                                return
                            }
                        }
                    }
//                    self.delegate?.didFailedCategoriesAPICall()
                    completionError(NSError(domain: "SPLTCategoriesAPI", code: 1, userInfo: nil))
        }
        
    }
    
    
}



