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

open class DSHorizontalTableViewCell: SPLTHorizontalBaseTableViewCell {
    
    open override func awakeFromNib() {
        super.awakeFromNib()
        self.collectionView?.register(UINib(nibName: "DSHorizontalCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "DSHorizontalCollectionViewCell")
    }
    
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
    
//    open override func setCellData(_ dspCategory: SPLTCategory, collectionViewItemSize: CGSize, collectionViewImageSize: CGSize) {
//        super.setCellData(dspCategory, collectionViewItemSize: collectionViewItemSize, collectionViewImageSize: collectionViewImageSize)
//    }
    

///MARK: -
//MARK: - extension UICollectionViewDataSource

//    open override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return super.collectionView(collectionView, numberOfItemsInSection: section)
//    }
    open override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let dsHorizontalCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "DSHorizontalCollectionViewCell", for: indexPath) as? DSHorizontalCollectionViewCell {
            
            if let dspCategory = self.dspCategory {
                if dspCategory.channels.count > 1 {
                    if indexPath.section < dspCategory.channels.count {
                        let channel = dspCategory.channels[indexPath.row]
                        dsHorizontalCollectionViewCell.setDspChannel(dspChannel: channel, collectionViewImageSize: self.collectionViewImageSize)
                    }
                } else if dspCategory.channels.count == 1 {
                    if let dspPlaylistChannel = dspCategory.channels[0] as? SPLTPlaylistChannel {
                        if indexPath.section < dspPlaylistChannel.playlistVideos.count {
                            let video = dspPlaylistChannel.playlistVideos[indexPath.row]
                            dsHorizontalCollectionViewCell.setDspVideo(dspVideo: video, collectionViewImageSize: self.collectionViewImageSize)
                        }
                    }
                }
            }
            return dsHorizontalCollectionViewCell
            
        }
        return UICollectionViewCell()
    }
}


