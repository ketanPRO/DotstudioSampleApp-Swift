//
//  DSHorizontalBaseTableViewCell.swift
//  DotstudioSampleApp
//
//  Created by Ketan Sakariya on 10/05/18.
//  Copyright © 2018 Dotstudioz. All rights reserved.
//

import Foundation
import UIKit
import DotstudioAPI
import DotstudioUI
import Haneke

open class DSHorizontalBaseCollectionViewCell: SPLTHorizontalBaseCollectionViewCell  {
//    @IBOutlet weak open var imageViewCell: SPLTBaseImageView?
//    @IBOutlet weak open var labelPrimaryTitle: UILabel?
//    @IBOutlet weak open var labelSecondaryTitle: UILabel?
    
    @IBOutlet open override var imageViewCell: SPLTBaseImageView? {
        get {
            return super.imageViewCell
        }
        set {
            super.imageViewCell = newValue
        }
    }
    @IBOutlet weak open override var labelPrimaryTitle: UILabel? {
        get {
            return super.labelPrimaryTitle
        }
        set {
            super.labelPrimaryTitle = newValue
        }
    }
    @IBOutlet weak open override var labelSecondaryTitle: UILabel? {
        get {
            return super.labelSecondaryTitle
        }
        set {
            super.labelSecondaryTitle = newValue
        }
    }
//    open override func setDspChannel(dspChannel: SPLTChannel) {
//        self.dspChannel = dspChannel
//        var strImageUrl = "" //"https://f9q4g5j6.ssl.hwcdn.net/5a5816cd97f8156c1988d889"
//        if let strPosterUrl = dspChannel.poster {
//            strImageUrl = strPosterUrl
////            self.imageViewCell?.image = UIImage(contentsOfFile: strImageUrl)
////            if let url = URL(string: strImageUrl) {
////                self.imageViewCell?.hnk_setImageFromURL(url)
////            }
//            self.imageViewCell?.splt_setImageFromStrImagePath(strImageUrl)
//        }
//        if let strTitle = dspChannel.strTitle {
//            self.labelPrimaryTitle?.text = strTitle
//        }
//        self.labelSecondaryTitle?.text = ""
//    }
    open override func setDspVideo(dspVideo: SPLTVideo) {
        self.dspVideo = dspVideo
        if let strThumbUrl = dspVideo.thumb {
//            self.imageViewCell?.image = UIImage(contentsOfFile: strThumbUrl)
//            if let url = URL(string: strThumbUrl) {
//                self.imageViewCell?.hnk_setImageFromURL(url)
//            }
            self.imageViewCell?.splt_setImageFromStrImagePath(strThumbUrl)
        }
        if let strTitle = dspVideo.strTitle {
            self.labelPrimaryTitle?.text = strTitle
        }
        self.labelSecondaryTitle?.text = ""
    }
}


//MARK:-
//MARK:-
//MARK:- TableView Cells
//protocol SPLTHorizontalBaseTableViewCellDelegate {
//    open func spltHorizontalBaseTableViewCell(_ spltHorizontalBaseTableViewCell: SPLTHorizontalBaseTableViewCell, didSelectChannel dspChannel: SPLTChannel, atIndex index: Int)
//    open func spltHorizontalBaseTableViewCell(_ spltHorizontalBaseTableViewCell: SPLTHorizontalBaseTableViewCell, didSelectVideo dspVideo: SPLTVideo, inChannel dspChannel: SPLTChannel?, atIndex index: Int)
//}


open class DSHorizontalBaseTableViewCell: SPLTHorizontalBaseTableViewCell {
//    open var delegate: SPLTHorizontalBaseTableViewCellDelegate?
//    open var dspCategory: SPLTCategory?
    @IBOutlet weak open override var labelTitle: UILabel? {
        get {
            return super.labelTitle
        }
        set {
            super.labelTitle = newValue
        }
    }
    @IBOutlet weak open override var collectionView: UICollectionView? {
        get {
            return super.collectionView
        }
        set {
            super.collectionView = newValue
        }
    }
    

    open override func setCellData(_ dspCategory: SPLTCategory, sizeCollectionViewItem: CGSize) {
        self.resetCollectionViewSize(sizeCollectionViewItem)
        self.dspCategory = dspCategory
        self.dspCategory?.delegate = self
        if let strTitle = dspCategory.strName {
            self.labelTitle?.text = strTitle
        }
        if dspCategory.channels.count > 1 {
            self.collectionView?.reloadData()
        } else if dspCategory.channels.count == 1 {
            if let dspPlaylistChannel = dspCategory.channels[0] as? SPLTPlaylistChannel {
                dspPlaylistChannel.loadFullChannel({ (channelDict) in
                    // success
                    self.collectionView?.reloadData()
                }) { (error) in
                    // error
                }
            }
        }
    }
    
//    func resetCollectionViewSize(_ sizeCollectionViewItem: CGSize) {
//        super.resetCollectionViewSize(sizeCollectionViewItem)
//    }
    
}

///MARK: -
//MARK: - extension UICollectionViewDataSource
extension DSHorizontalBaseTableViewCell {
    
    open override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let dspCategory = self.dspCategory {
            if dspCategory.channels.count > 1 {
                return dspCategory.channels.count
            } else if dspCategory.channels.count == 1 {
                if let dspPlaylistChannel = dspCategory.channels[0] as? SPLTPlaylistChannel {
                    return dspPlaylistChannel.playlistVideos.count
                }
            }
        }
        
        return 0
    }
    open override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let dsHorizontalBaseCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "DSHorizontalBaseCollectionViewCell", for: indexPath) as? DSHorizontalBaseCollectionViewCell {
            
            if let dspCategory = self.dspCategory {
                if dspCategory.channels.count > 1 {
                    if indexPath.section < dspCategory.channels.count {
                        let channel = dspCategory.channels[indexPath.row]
                        dsHorizontalBaseCollectionViewCell.setDspChannel(dspChannel: channel)
                    }
                } else if dspCategory.channels.count == 1 {
                    if let dspPlaylistChannel = dspCategory.channels[0] as? SPLTPlaylistChannel {
                        if indexPath.section < dspPlaylistChannel.playlistVideos.count {
                            let video = dspPlaylistChannel.playlistVideos[indexPath.row]
                            dsHorizontalBaseCollectionViewCell.setDspVideo(dspVideo: video)
                        }
                    }
                }
            }
            return dsHorizontalBaseCollectionViewCell
            
        }
        return UICollectionViewCell()
    }
}

//MARK: -
//MARK: - extension UICollectionViewDelegateFlowLayout
extension DSHorizontalBaseTableViewCell {
}




