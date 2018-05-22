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


//protocol DSHorizontalTableViewCellDelegate: SPLTHorizontalBaseTableViewCellDelegate {
//
//}
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
            }
        } else {
            if let dsHorizontalTableViewCell = tableView.dequeueReusableCell(withIdentifier: "DSHorizontalTableViewCell") as? DSHorizontalTableViewCell {
                dsHorizontalTableViewCell_ = dsHorizontalTableViewCell
            }
        }
        
        if let dsHorizontalTableViewCell = dsHorizontalTableViewCell_ {
            let category = self.categoriesBrowse[indexPath.section]
            let collectionViewItemSize = self.getCollectionViewItemSizeAtIndexPath(indexPath)
            let collectionViewImageSize = self.getCollectionViewImageSizeAtIndexPath(indexPath)
            dsHorizontalTableViewCell.delegate = self
            dsHorizontalTableViewCell.setCellData(category, collectionViewItemSize: collectionViewItemSize, collectionViewImageSize: collectionViewImageSize)
            return dsHorizontalTableViewCell
        }
        return UITableViewCell()
    }
    
    
    open override func getCollectionViewItemSizeAtIndexPath(_ indexPath: IndexPath) -> CGSize {
        let size = super.getCollectionViewItemSizeAtIndexPath(indexPath)
        print(size)
        return size
    }
    open override func getCollectionViewImageSizeAtIndexPath(_ indexPath: IndexPath) -> CGSize {
        let size = super.getCollectionViewImageSizeAtIndexPath(indexPath)
        print(size)
        return size
    }
}

//extension DSBrowseViewController: DSHorizontalTableViewCellDelegate {
//    public func spltHorizontalBaseTableViewCell(_ spltHorizontalBaseTableViewCell: SPLTHorizontalBaseTableViewCell, didSelectChannel channel: SPLTChannel, atIndex index: Int) {
//        print("channel selected")
//    }
//
//    public func spltHorizontalBaseTableViewCell(_ spltHorizontalBaseTableViewCell: SPLTHorizontalBaseTableViewCell, didSelectVideo video: SPLTVideo, inChannel channel: SPLTChannel?, atIndex index: Int) {
//        print("video selected")
//    }
//
//
//}





