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
            let spltTabBarBaseNavigationViewController = SPLTTabBarBaseNavigationViewController(rootViewController: dsBrowseViewController)
            self.tabViewControllers.append(dsBrowseViewController)
            self.tabBarNavigationViewControllers.append(spltTabBarBaseNavigationViewController)
        }
    }
    
    open override func addCategoriesViewController() {
        if let dsCategoriesViewController = self.getViewControllerFromStoryboardName("categories", strViewControllerIdentifier: "DSCategoriesViewController") as? DSCategoriesViewController {
            self.spltCategoriesViewController = dsCategoriesViewController
            let spltTabBarBaseNavigationViewController = SPLTTabBarBaseNavigationViewController(rootViewController: dsCategoriesViewController)
            self.tabViewControllers.append(dsCategoriesViewController)
            self.tabBarNavigationViewControllers.append(spltTabBarBaseNavigationViewController)
        }
    }
    
}

extension DSHomeTabBarController {
    open override func didUpdateCategoryChannelsForCategory(_ category: SPLTCategory) {
        //self.updateUI()
    }
}


