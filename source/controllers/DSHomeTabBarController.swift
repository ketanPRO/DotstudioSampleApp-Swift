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
    
    open override func addBrowseViewController() {
        if let dsBrowseViewController = self.getViewControllerFromStoryboardName("browse", strViewControllerIdentifier: "DSBrowseViewController") as? DSBrowseViewController {
            self.spltBrowseViewController = dsBrowseViewController
            self.tabViewControllers.append(dsBrowseViewController)
            #if os(iOS)
                let spltTabBarBaseNavigationViewController = SPLTTabBarBaseNavigationViewController(rootViewController: dsBrowseViewController)
                self.tabBarNavigationViewControllers.append(spltTabBarBaseNavigationViewController)
            #elseif os(tvOS)
                self.setViewControllers(self.tabViewControllers, animated: false)
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
            #elseif os(tvOS)
                self.setViewControllers(self.tabViewControllers, animated: false)
            #endif
        }
    }
    
}

extension DSHomeTabBarController {
    open override func didUpdateCategoryChannelsForCategory(_ category: SPLTCategory) {
        //self.updateUI()
    }
}


