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
        self.tableView?.register(UINib(nibName: "DSHorizontalBaseTableViewCell", bundle: nil), forCellReuseIdentifier: "DSHorizontalBaseTableViewCell")
    }
    
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





