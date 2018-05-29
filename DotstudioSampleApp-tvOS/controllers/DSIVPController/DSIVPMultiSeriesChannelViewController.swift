//
//  DSIVPMultiSeriesChannelViewController.swift
//  DotstudioSampleApp-tvOS
//
//  Created by Anwer on 5/22/18.
//  Copyright © 2018 Dotstudioz. All rights reserved.
//

import UIKit
import DotstudioUI
import DotstudioAPI

public protocol DSIVPMultiSeriesChannelViewControllerDelegate {
    func didClickCloseButton(_ dsIVPMultiSeriesChannelViewController: DSIVPMultiSeriesChannelViewController)
}

public class DSIVPMultiSeriesChannelViewController: UIViewController {

    var delegate: DSIVPMultiSeriesChannelViewControllerDelegate?
    var channel:SPLTChannel?
    var curVideo: SPLTVideo?
    var autoPlayIndex: Int?
    override public func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override public func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
