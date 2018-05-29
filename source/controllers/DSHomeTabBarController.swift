//
//  DSHomeTabBarController.swift
//  DotstudioSampleApp-iOS
//
//  Created by Ketan Sakariya on 09/05/18.
//  Copyright © 2018 Dotstudioz. All rights reserved.
//

import Foundation
import DotstudioUI
import DotstudioAPI
import UIKit

@IBDesignable
open class DSHomeTabBarController: SPLTHomeTabBarController {

    open override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    open override func addTabBarViewControllers() {
        self.addBrowseViewController()
        self.addCategoriesViewController()
        self.addSearchViewController()
    }
    open override func addBrowseViewController() {
        if let dsBrowseViewController = self.getViewControllerFromStoryboardName("browse", strViewControllerIdentifier: "DSBrowseViewController") as? DSBrowseViewController {
            self.spltBrowseViewController = dsBrowseViewController
            self.tabViewControllers.append(dsBrowseViewController)
            #if os(iOS)
                let spltTabBarBaseNavigationViewController = SPLTTabBarBaseNavigationViewController(rootViewController: dsBrowseViewController)
                self.tabBarNavigationViewControllers.append(spltTabBarBaseNavigationViewController)
            #endif
        }
    }
    
    open override func addCategoriesViewController() {
        if let dsCategoriesViewController = self.getViewControllerFromStoryboardName("categories", strViewControllerIdentifier: "DSCategoriesViewController") as? DSCategoriesViewController {
            self.spltCategoriesViewController = dsCategoriesViewController
            self.tabViewControllers.append(dsCategoriesViewController)
            #if os(iOS)
                let spltTabBarBaseNavigationViewController = SPLTTabBarBaseNavigationViewController(rootViewController: dsCategoriesViewController)
                self.tabBarNavigationViewControllers.append(spltTabBarBaseNavigationViewController)
            #endif
        }
    }
    
    open func addSearchViewController() {
        if let dsSearchViewController = self.getViewControllerFromStoryboardName("search", strViewControllerIdentifier: "DSSearchViewController") as? DSSearchViewController {
//            self.spltCategoriesViewController = dsSearchViewController
            self.tabViewControllers.append(dsSearchViewController)
            #if os(iOS)
            let spltTabBarBaseNavigationViewController = SPLTTabBarBaseNavigationViewController(rootViewController: dsSearchViewController)
            self.tabBarNavigationViewControllers.append(spltTabBarBaseNavigationViewController)
            #endif
        }
    }
    
}

extension DSHomeTabBarController {
    open override func didUpdateCategoryChannelsForCategory(_ category: SPLTCategory) {
        //self.updateUI()
    }
}

//MARK: - SPLTIVPPresentor methods
extension DSHomeTabBarController: SPLTIVPPresentor {
    
    public func openIVPViewControllerVideo(video: SPLTVideo?, in channel: SPLTChannel?, atAutoPlayIndex autoPlayIndex: Int?, spltIVPViewControllerDelegate: SPLTIVPPresentorDelegate?) {

//    public func openIVPViewControllerVideo(video: SPLTVideo?, in channel: SPLTChannel?, atAutoPlayIndex autoPlayIndex: Int?, spltIVPViewControllerDelegate: SPLTIVPViewControllerDelegate?) {
        if let dsIVPMultiSeriesChannelViewController = self.getViewControllerFromStoryboardName("ivp", strViewControllerIdentifier: "DSIVPMultiSeriesChannelViewController") as? DSIVPMultiSeriesChannelViewController {
            dsIVPMultiSeriesChannelViewController.channel = channel
            dsIVPMultiSeriesChannelViewController.autoPlayIndex = autoPlayIndex
            dsIVPMultiSeriesChannelViewController.curVideo = video
            dsIVPMultiSeriesChannelViewController.delegate = self
            self.present(dsIVPMultiSeriesChannelViewController, animated: true) {
                // success presented IVP...
            }
        }
    }
}

//MARK: - DSIVPMultiSeriesChannelViewControllerDelegate methods
extension DSHomeTabBarController: DSIVPMultiSeriesChannelViewControllerDelegate {
    public func didClickCloseButton(_ dsIVPMultiSeriesChannelViewController: DSIVPMultiSeriesChannelViewController) {
        dsIVPMultiSeriesChannelViewController.dismiss(animated: true) {
            // on success completion
        }
    }
    
}






