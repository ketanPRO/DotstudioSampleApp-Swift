//
//  SPLTBaseAPI.swift
//  DotstudioPRO
//
//  Created by Ketan Sakariya on 15/02/17.
//  Copyright © 2017 ___DotStudioz___. All rights reserved.
//

import Foundation
import Alamofire


open class SPLTBaseAPI: NSObject {

    static let sessionManager = SessionManager()
    var request: Alamofire.Request?
    static var spltTokenHandler: SPLTTokenHandler? {
        didSet {
            if let spltTokenHandler_ = spltTokenHandler {
                SPLTBaseAPI.sessionManager.adapter = spltTokenHandler_
                SPLTBaseAPI.sessionManager.retrier = spltTokenHandler_
            }
        }
    }

    func cancelRequest() {
        print("1: alamofire request cancelled.")
        self.request?.suspend()
        self.request?.cancel()
    }
}


