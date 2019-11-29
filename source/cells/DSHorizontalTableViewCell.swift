//
//  DSHorizontalBaseTableViewCell.swift
//  DotstudioSampleApp
//
//  Created by Ketan Sakariya on 10/05/18.
//  Copyright © 2018 Dotstudioz. All rights reserved.
//

import Foundation
import UIKit
import DotstudioPRO

protocol DSHorizontalTableViewCellDelegate {
    func didClickMylistButton(_ dsHorizontalTableViewCell: DSHorizontalTableViewCell, channel: SPLTChannel)
}

open class DSHorizontalTableViewCell: SPLTHorizontalBaseTableViewCell {
    
    var delegateDSHorizontalTableViewCellDelegate: DSHorizontalTableViewCellDelegate?
    
    @IBOutlet var buttonSeeAll: UIButton?
    
    var isInitialSetup: Bool = true
    open override func awakeFromNib() {
        super.awakeFromNib()
//        self.collectionView?.register(UINib(nibName: "DSHorizontalCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "DSHorizontalCollectionViewCell")
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
    
    open override func setCellData(_ category: SPLTCategory, collectionViewItemSize: CGSize, collectionViewImageSize: CGSize) {
        super.setCellData(category, collectionViewItemSize: collectionViewItemSize, collectionViewImageSize: collectionViewImageSize)
        self.setupButtonIcons()
        self.isInitialSetup = false
    }
    
    open func setupButtonIcons() {
        #if os(iOS)
        if self.isInitialSetup {
            //let imageIconDefaultSize = CGSize(width: 22, height: 22)
            //let imageSeeAllButton = UIImage(icon: .FAEllipsisH, size: imageIconDefaultSize, textColor: .black, backgroundColor: .clear)
            self.buttonSeeAll?.setTitle("View All", for: .normal)
            //self.buttonSeeAll?.setImage(imageSeeAllButton, for: .normal)
        }
        #endif
    }

//    open override func setCellData(_ dspCategory: SPLTCategory, collectionViewItemSize: CGSize, collectionViewImageSize: CGSize) {
//        super.setCellData(dspCategory, collectionViewItemSize: collectionViewItemSize, collectionViewImageSize: collectionViewImageSize)
//    }
    

///MARK: -
//MARK: - extension UICollectionViewDataSource

//    open override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return super.collectionView(collectionView, numberOfItemsInSection: section)
//    }
    
    open override func updateUI() {
        if self.category?.channels.count == 1 {
//        if category is SPLTCustomCategory {
//            let collectionViewItemSize = CGSize(width: 160.0, height: 120.0) //size
            self.resetCollectionViewSize(self.collectionViewItemSize)
//            self.collectionViewImageSize = CGSize(width: 160.0, height: 90.0) //size
        }
        
        super.updateUI()
        
        if let strName = self.category?.strName {
            self.labelTitle?.text = strName//.localizedUppercase
        }
        
        if self.category is SPLTCustomCategory {
            if let strName = self.category?.strName {
                self.labelTitle?.text = strName//.uppercased()
            }
        }
    }
    
//    open override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        if let category = self.category {
//            if category is SPLTCustomCategory {
//                if let playlistChannel = category.channels[0] as? SPLTPlaylistChannel {
//                    return playlistChannel.playlistVideos.count
//                }
//            } else {
//                return category.channels.count
//            }
//        }
//        return 0
//    }
    open override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let category = self.category {
            if category.channels.count > 1 {
                if let dsHorizontalCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "DSHorizontalCollectionViewCell", for: indexPath) as? DSHorizontalCollectionViewCell {
                    if indexPath.row < category.channels.count {
                        let channel = category.channels[indexPath.row]
                        dsHorizontalCollectionViewCell.delegateDSHorizontalCollectionViewCellDelegate = self
                        dsHorizontalCollectionViewCell.setChannel(channel: channel, collectionViewImageSize: self.collectionViewImageSize)
                        return dsHorizontalCollectionViewCell
                    }
                }
            }else if let videoChannel = category.channels[0] as? SPLTVideoChannel{
                    if let dsHorizontalCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "DSHorizontalCollectionViewCell", for: indexPath) as? DSHorizontalCollectionViewCell {
                        dsHorizontalCollectionViewCell.delegateDSHorizontalCollectionViewCellDelegate = self
                        if let video = videoChannel.video{
                            dsHorizontalCollectionViewCell.setVideo(video: video, collectionViewImageSize: self.collectionViewImageSize)
                        }
                        return dsHorizontalCollectionViewCell
                    }
                }
            }
//        }
        
        return UICollectionViewCell()
    }
    
    @IBAction func didClickSeeAllButton(sender: UIButton) {
        if let category = self.category {
            self.delegate?.spltHorizontalBaseTableViewCell(self, didSelectCategory: category)
        }
    }
    
//    #if os(tvOS)
//    override open func didUpdateFocus(in context: UIFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
//        super.didUpdateFocus(in: context, with: coordinator)
//        if context.nextFocusedView ==  self.buttonSeeAll {
//            self.buttonSeeAll?.backgroundColor = UIColor(red: 17/255, green: 221/255, blue: 245/255, alpha: 1.0)
//            self.buttonSeeAll?.setTitleColor(UIColor.white, for: .normal)
//        } else {
//            self.buttonSeeAll?.backgroundColor = UIColor.black
//            self.buttonSeeAll?.setTitleColor(UIColor.white, for: .normal)
//        }
//    }
//    #endif
}

extension DSHorizontalTableViewCell: DSHorizontalCollectionViewCellDelegate {
    public func didClickMylistButton(_ dsHorizontalCollectionViewCell: DSHorizontalCollectionViewCell, channel: SPLTChannel) {
        self.delegateDSHorizontalTableViewCellDelegate?.didClickMylistButton(self, channel: channel)
    }
}


