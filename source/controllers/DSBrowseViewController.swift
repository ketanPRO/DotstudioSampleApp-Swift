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
    
//    @IBInspectable override open var tableViewHeight: CGFloat {
//        get {
//            return super.tableViewHeight
//        }
//        set {
//            super.tableViewHeight = newValue
//        }
//    }
//    
//    @IBInspectable override open var collectionViewItemSize: CGSize {
//        get {
//            return super.collectionViewItemSize
//        }
//        set {
//            super.collectionViewItemSize = newValue
//        }
//    }
    
    
    
    open override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView?.register(UINib(nibName: "DSFeaturedHorizontalTableViewCell", bundle: nil), forCellReuseIdentifier: "DSFeaturedHorizontalTableViewCell")
        self.tableView?.register(UINib(nibName: "DSHorizontalTableViewCell", bundle: nil), forCellReuseIdentifier: "DSHorizontalTableViewCell")
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            let width = self.view.frame.width
            let height = width * 9.0 / 16.0
            return height
        }
        return self.tableViewHeight
    }
    
    open override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var dsHorizontalTableViewCell_: DSHorizontalTableViewCell?

        if indexPath.section < self.categoriesBrowse.count {
            let category = self.categoriesBrowse[indexPath.section]
            var collectionViewItemSize = self.collectionViewItemSize
            var collectionViewImageSize = self.collectionViewImageSize
            if indexPath.section == 0 {
                if let dsFeaturedHorizontalTableViewCell = tableView.dequeueReusableCell(withIdentifier: "DSFeaturedHorizontalTableViewCell") as? DSFeaturedHorizontalTableViewCell {
                    dsHorizontalTableViewCell_ = dsFeaturedHorizontalTableViewCell
                    let width = self.view.frame.width
                    let height = width * 9.0 / 16.0
                    let size = CGSize(width: width, height: height)
                    collectionViewItemSize = size
                    collectionViewImageSize = size
                }
            } else {
                if let dsHorizontalTableViewCell = tableView.dequeueReusableCell(withIdentifier: "DSHorizontalTableViewCell") as? DSHorizontalTableViewCell {
                    dsHorizontalTableViewCell_ = dsHorizontalTableViewCell
                }
            }
            
            if let dsHorizontalTableViewCell = dsHorizontalTableViewCell_ {
                let category = self.categoriesBrowse[indexPath.section]
                dsHorizontalTableViewCell.delegate = self
                dsHorizontalTableViewCell.setCellData(category, collectionViewItemSize: collectionViewItemSize, collectionViewImageSize: collectionViewImageSize)
                return dsHorizontalTableViewCell
            }

        }
        
        return UITableViewCell()
    }
    
    open override func spltHorizontalBaseTableViewCell(_ spltHorizontalBaseTableViewCell: SPLTHorizontalBaseTableViewCell, didSelectVideo video: SPLTVideo, inChannel channel: SPLTChannel?, atIndex index: Int) {
//        if let channel = self.category?.channels[index] {
            if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
                if let spltIVPPresentor = appDelegate.window?.rootViewController as? SPLTIVPPresentor {
                    spltIVPPresentor.openIVPViewControllerVideo(video: video, in: channel, atAutoPlayIndex: index, spltIVPViewControllerDelegate: nil)
                }
            }
//        }
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





