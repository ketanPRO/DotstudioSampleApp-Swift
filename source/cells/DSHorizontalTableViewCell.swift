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
    
}

///MARK: -
//MARK: - extension UICollectionViewDataSource
extension DSHorizontalTableViewCell {
    
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
        if let dsHorizontalCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "DSHorizontalCollectionViewCell", for: indexPath) as? DSHorizontalCollectionViewCell {
            
            if let dspCategory = self.dspCategory {
                if dspCategory.channels.count > 1 {
                    if indexPath.section < dspCategory.channels.count {
                        let channel = dspCategory.channels[indexPath.row]
                        dsHorizontalCollectionViewCell.setDspChannel(dspChannel: channel)
                    }
                } else if dspCategory.channels.count == 1 {
                    if let dspPlaylistChannel = dspCategory.channels[0] as? SPLTPlaylistChannel {
                        if indexPath.section < dspPlaylistChannel.playlistVideos.count {
                            let video = dspPlaylistChannel.playlistVideos[indexPath.row]
                            dsHorizontalCollectionViewCell.setDspVideo(dspVideo: video)
                        }
                    }
                }
            }
            return dsHorizontalCollectionViewCell
            
        }
        return UICollectionViewCell()
    }
}


