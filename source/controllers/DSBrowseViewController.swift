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
    
    @IBInspectable override open var tableViewHeight: CGFloat {
        get {
            return super.tableViewHeight
        }
        set {
            super.tableViewHeight = newValue
        }
    }
    
    @IBInspectable override open var collectionViewItemSize: CGSize {
        get {
            return super.collectionViewItemSize
        }
        set {
            super.collectionViewItemSize = newValue
        }
    }
    
    
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView?.register(UINib(nibName: "DSFeaturedHorizontalTableViewCell", bundle: nil), forCellReuseIdentifier: "DSFeaturedHorizontalTableViewCell")
        self.tableView?.register(UINib(nibName: "DSHorizontalTableViewCell", bundle: nil), forCellReuseIdentifier: "DSHorizontalTableViewCell")
    }
    
    
    open override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var dsHorizontalTableViewCell_: DSHorizontalTableViewCell?

        if indexPath.section == 0 {
            if let dsFeaturedHorizontalTableViewCell = tableView.dequeueReusableCell(withIdentifier: "DSFeaturedHorizontalTableViewCell") as? DSFeaturedHorizontalTableViewCell {
                dsHorizontalTableViewCell_ = dsFeaturedHorizontalTableViewCell
                
//                let category = self.categoriesBrowse[indexPath.section]
//                let collectionViewItemWidth = tableView.frame.width
//                let collectionViewItemHeight = (collectionViewItemWidth * 9.0 / 16.0)
//                let collectionViewItemSize = CGSize(width: collectionViewItemWidth, height: collectionViewItemHeight)
//
//                dsFeaturedHorizontalTableViewCell.setCellData(category, sizeCollectionViewItem: collectionViewItemSize)
//                return dsFeaturedHorizontalTableViewCell
            }
        } else {
            if let dsHorizontalTableViewCell = tableView.dequeueReusableCell(withIdentifier: "DSHorizontalTableViewCell") as? DSHorizontalTableViewCell {
                dsHorizontalTableViewCell_ = dsHorizontalTableViewCell
                
//                let category = self.categoriesBrowse[indexPath.section]
//                let size = self.getCollectionViewItemSize()
//                dsHorizontalTableViewCell.setCellData(category, sizeCollectionViewItem: size)
//                return dsHorizontalTableViewCell
            }
        }
        
        if let dsHorizontalTableViewCell = dsHorizontalTableViewCell_ {
            let category = self.categoriesBrowse[indexPath.section]
            let size = self.getCollectionViewItemSizeAtIndexPath(indexPath)
            dsHorizontalTableViewCell.setCellData(category, sizeCollectionViewItem: size)
            return dsHorizontalTableViewCell
        }
        return UITableViewCell()
    }
    
    /*open override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }*/

    
    func reloadCategory(category: SPLTCategory) {
        if let index = self.categoriesBrowse.index(of: category) {
            self.reloadSectionAtIndex(index: index)
        }
    }
    
}





