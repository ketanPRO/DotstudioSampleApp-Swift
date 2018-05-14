//
//  DSBrowseViewController.swift
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
open class DSBrowseViewController: SPLTBrowseViewController {
    
    @IBOutlet weak open override var tableView: UITableView? {
        get {
            return super.tableView
        }
        set {
            super.tableView = newValue
        }
    }
    open override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
//    open func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        let tableViewWidth = tableView.frame.width
//
//        if indexPath.section == 0 {
//            return (tableViewWidth * 9.0 / 16.0) + 30
//        }
//        if indexPath.section < self.categoriesBrowse.count {
//            let category = self.categoriesBrowse[indexPath.section]
//            if category.channels.count > 1 {
//                return self.getTableViewHeight()
//            } else {
//                return self.getTableViewHeight()
//            }
//        }
//
//        return self.getTableViewHeight()
//    }
    open override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            if let spltFeaturedHorizontalTableViewCell = tableView.dequeueReusableCell(withIdentifier: "SPLTFeaturedHorizontalTableViewCell") as? SPLTFeaturedHorizontalTableViewCell {
                let category = self.categoriesBrowse[indexPath.section]
                let size = self.getCollectionViewItemSize()
                spltFeaturedHorizontalTableViewCell.setCellData(category, sizeCollectionViewItem: size)
                return spltFeaturedHorizontalTableViewCell
                
            }
            
        } else {
            if let dsHorizontalBaseTableViewCell = tableView.dequeueReusableCell(withIdentifier: "DSHorizontalBaseTableViewCell") as? DSHorizontalBaseTableViewCell {
                let category = self.categoriesBrowse[indexPath.section]
                let size = self.getCollectionViewItemSize()
                dsHorizontalBaseTableViewCell.setCellData(category, sizeCollectionViewItem: size)
                return dsHorizontalBaseTableViewCell
                
            }
        }
        
        return UITableViewCell() //tableView.dequeueReusableCell(withIdentifier: "cell")!
    }

    
    func reloadCategory(category: SPLTCategory) {
        if let index = self.categoriesBrowse.index(of: category) {
            self.reloadSectionAtIndex(index: index)
        }
    }
    
}





