//
//  DSFeaturedHorizontalTableViewCell.swift
//  DotstudioSampleApp-iOS
//
//  Created by Ketan Sakariya on 11/05/18.
//  Copyright © 2018 Dotstudioz. All rights reserved.
//

import Foundation
import UIKit
import DotstudioPRO

open class DSFeaturedHorizontalTableViewCell: DSHorizontalTableViewCell  {
    @IBOutlet weak open override var collectionView: UICollectionView? {
        get {
            return super.collectionView
        }
        set {
            super.collectionView = newValue
        }
    }
    @IBOutlet weak open override var pageControl: UIPageControl? {
        get {
            return super.pageControl
        }
        set {
            super.pageControl = newValue
        }
    }
    @IBOutlet weak open var infiniteCarousel: InfiniteCarousel?
    @IBOutlet weak open var buttonWatchNow: UIButton?
    
    open override func awakeFromNib() {
        super.awakeFromNib()
//        self.collectionView?.register(UINib(nibName: "DSFeaturedHorizontalCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "DSFeaturedHorizontalCollectionViewCell")
    }
    
    open override func setCellData(_ category: SPLTCategory, collectionViewItemSize: CGSize, collectionViewImageSize: CGSize) {
        super.setCellData(category, collectionViewItemSize: collectionViewItemSize, collectionViewImageSize: collectionViewImageSize)
    }
    
//    override open func updateUI() {
//        super.updateUI()
//        if let category = self.category {
//            if category.channels.count == 1 {
//                // playlist channel...
//                if let playlistChannel = category.channels.first as? SPLTPlaylistChannel {
//                    self.pageControl?.numberOfPages = playlistChannel.playlistVideos.count
//                }
//            } else if category.channels.count > 1 {
//                self.pageControl?.numberOfPages = category.channels.count
//            }
//        }
//    }
    #if os(tvOS)
//    override open func didUpdateFocus(in context: UIFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
//        super.didUpdateFocus(in: context, with: coordinator)
//        if self.isFocused {
//            self.buttonWatchNow?.setTitleColor(.white, for: .normal)
//            self.buttonWatchNow?.setTitleColor(.white, for: .focused)
//            self.buttonWatchNow?.backgroundColor = UIColor(hexString: "#ED1D1D") //.red
//        } else {
//            self.buttonWatchNow?.setTitleColor(.white, for: .normal)
//            self.buttonWatchNow?.setTitleColor(.white, for: .focused)
//            self.buttonWatchNow?.backgroundColor = UIColor(hexString: "#1E1F1F") //.black
//        }
//    }
    #endif
    
    open override func updatePageIndicatorUI(){
        if let category = self.category {
            self.pageControl?.numberOfPages = category.channels.count
            self.pageControl?.currentPage = 0
        }
    }
    
    
    open override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let category = self.category {
            return category.channels.count
        }
        return 0
    }
    
    open override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        //Note: This change is done because when there is only one records in HomePageCarousel category the app was getting crashed.
        
        if let category = self.category {
            if let dsFeaturedHorizontalCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "DSFeaturedHorizontalCollectionViewCell", for: indexPath) as? DSFeaturedHorizontalCollectionViewCell {
                dsFeaturedHorizontalCollectionViewCell.delegate = self
                if indexPath.row < category.channels.count {
                    let channel = category.channels[indexPath.row]
                    dsFeaturedHorizontalCollectionViewCell.setChannel(channel: channel, collectionViewImageSize: self.collectionViewImageSize)
                    return dsFeaturedHorizontalCollectionViewCell
                }
            }
        }
        
        return UICollectionViewCell()
    }
    
}

///MARK: -
//MARK: - extension UICollectionViewDataSource
extension DSFeaturedHorizontalTableViewCell {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if let infiniteCarouselCollectionView = self.collectionView as? InfiniteCarousel {
            let currentlyFocusedItem = infiniteCarouselCollectionView.adjustedCurrentlyFocusedItem
            if let pageControl = self.pageControl {
                if pageControl.numberOfPages != 0 {
                    pageControl.currentPage = currentlyFocusedItem % pageControl.numberOfPages
                }
            }
        }
    }
}


///MARK: -
//MARK: - extension UICollectionViewDataSource
extension DSFeaturedHorizontalTableViewCell: DSFeaturedHorizontalCollectionViewCellDelegate {
    func didFaildToAddChannelToWatchList(_ dsFeaturedHorizontalCollectionViewCell: DSFeaturedHorizontalCollectionViewCell, channel: SPLTChannel) {
//        _ = DSUtility.shared.showAlertOnWindow("App Name", message: "Channel faild to add in my list.", preferredStyle: .alert)
    }
    
    func didAddedChannelToWatchList(_ dsFeaturedHorizontalCollectionViewCell: DSFeaturedHorizontalCollectionViewCell, channel: SPLTChannel) {
//       _ = DSUtility.shared.showAlertOnWindow("App Name", message: "Channel added to my list successfully.", preferredStyle: .alert)
    }
    
    func didClickWatchNowButton(_ dsFeaturedHorizontalCollectionViewCell: DSFeaturedHorizontalCollectionViewCell) {
        if let indexPath = self.collectionView?.indexPath(for: dsFeaturedHorizontalCollectionViewCell) {
            if let category = self.category {
                if category.channels.count > 1 {
                    let channel = category.channels[indexPath.row]
                    self.delegate?.spltHorizontalBaseTableViewCell(self, didSelectChannel: channel, atIndex: indexPath.row)
                } else if category.channels.count == 1 {
                    if let playlistChannel = category.channels[0] as? SPLTPlaylistChannel {
                        let video = playlistChannel.playlistVideos[indexPath.row]
                        self.delegate?.spltHorizontalBaseTableViewCell(self, didSelectVideo: video, inChannel: playlistChannel, atIndex: indexPath.row)
                    }
                }
            }
        }
    }
    
  
    
    
}


