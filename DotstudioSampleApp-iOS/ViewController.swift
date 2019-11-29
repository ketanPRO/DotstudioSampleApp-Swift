//
//  ViewController.swift
//  DotstudioSampleApp-Swift
//
//  Created by primesoft on 08/05/18.
//  Copyright © 2018 Dotstudioz. All rights reserved.
//

import UIKit
import DotstudioPRO 

@IBDesignable
class ViewController: SPLTSplashViewController {
    @IBInspectable override var isVideoSplash: Bool {
        get {
            return super.isVideoSplash
        }
        set {
            super.isVideoSplash = newValue
        }
    }
    
    @IBInspectable override var autoTimeOutDuration: Double {
        get {
            return super.autoTimeOutDuration
        }
        set {
            super.autoTimeOutDuration = newValue
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
         SPLTTokenAPI().getToken { (accessToken) in
            print(accessToken)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

