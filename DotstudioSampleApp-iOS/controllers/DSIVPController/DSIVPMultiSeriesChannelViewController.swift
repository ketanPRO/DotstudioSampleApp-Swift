//
//  DSIVPMultiSeriesChannelViewController.swift
//  DotstudioSampleApp-iOS
//
//  Created by Anwer on 5/17/18.
//  Copyright © 2018 Dotstudioz. All rights reserved.
//
import UIKit
import DotstudioPRO

////TODO We will remove this once we get the real apis
//extension SPLTVideo {
//    class func getDummyVideo() -> SPLTVideo {
//        let video = SPLTVideo()
//        video.strTitle = "Video Title"
//        video.strSeriesTitle = "Series Title"
//        video.strVideoInfo = "Info"
//        video.strDescription = "We have a subclass for our cell, now let's create the view controller class. Inside the viewDidLoad method you have to set the estimatedItemSize property on the collection view. There if you give wrong size, the autorotation won't work as expected."
//        video.thumb = "http://via.placeholder.com/320x180"
//        video.progressPoint = 70
//        video.iDuration = 400
//        return video
//    }
//}
public protocol DSIVPMultiSeriesChannelViewControllerDelegate {
    func didClickCloseButton(_ dsIVPMultiSeriesChannelViewController: DSIVPMultiSeriesChannelViewController)
}

open class DSIVPMultiSeriesChannelViewController: SPLTIVPMultiSeriesChannelViewController {
    var delegate: DSIVPMultiSeriesChannelViewControllerDelegate?
    @IBOutlet weak open override var collectionView: UICollectionView? {
        get {
            return super.collectionView
        }
        set {
            
            super.collectionView = newValue
        }
    }
    var isCurrentVideoExpanded:Bool = false
    @IBOutlet weak open var viewDotstudioIMAPlayer: UIView!
    var dspPlayerViewController: DSPPlayerViewController?
    var offscreenCells: [String: Any] = [:]

    override open func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        if let dspPlayerViewController = DSPPlayerViewController.getViewController(theme: nil)as? DSPPlayerViewController{
            dspPlayerViewController.delegate = self
            self.dspPlayerViewController = dspPlayerViewController
            self.splt_configureChildViewController(childController: dspPlayerViewController, onView: self.viewDotstudioIMAPlayer)
        }
        
        self.collectionView?.register(UINib(nibName: "DSIVPCurrentVideoDetailTableViewCell", bundle: nil), forCellWithReuseIdentifier: "DSIVPCurrentVideoDetailTableViewCell")
        self.collectionView?.register(UINib(nibName: "DSIVPVideoDetailTableViewCell", bundle: nil), forCellWithReuseIdentifier: "DSIVPVideoDetailTableViewCell")
        self.collectionView?.register(UINib(nibName: "DSIVPRecommendedVideoDetailTableViewCell", bundle: nil), forCellWithReuseIdentifier: "DSIVPRecommendedVideoDetailTableViewCell")
        self.collectionView?.register(UINib(nibName: "DSIVPVideosSectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "DSIVPVideosSectionHeaderView")
        
//        self.resetCollectionViewSize()
    }
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        self.resetCollectionViewSize()
    }
    
    open override func requestChannel() {
        super.requestChannel()
    }
    open override func reloadAllData() {
        super.reloadAllData()
    }
    
//    func resetCollectionViewSize() {
//        if let collectionView = self.collectionView {
//            if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
//                flowLayout.minimumLineSpacing = CGFloat(0)
//                flowLayout.minimumInteritemSpacing = CGFloat(0)
//                flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0)
//                flowLayout.headerReferenceSize = CGSize(width: UIScreen.main.bounds.width, height: 30)
//                flowLayout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: 30)
//
////                if #available(iOS 10.0, *) {
////                    flowLayout.estimatedItemSize = UICollectionViewFlowLayoutAutomaticSize //CGSize(width: collectionView.frame.size.width, height: 120.0) //UICollectionViewFlowLayoutAutomaticSize
////                } else {
////                    // Fallback on earlier versions
////                    flowLayout.estimatedItemSize = CGSize(width: collectionView.frame.size.width, height: 120.0)
////                }
//            }
//        }
//    }
    //MARK: - Set Video methods.
    open override func setCurrentVideo(curVideo: SPLTVideo) {
        super.setCurrentVideo(curVideo: curVideo)
        self.dspPlayerViewController?.setCurrentVideo(curVideo: curVideo)
    }
    
    
    //MARK: - UICollectionViewDataSource methods
   
    
    override open func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        let iSections = super.numberOfSections(in: collectionView)
//        return 1
        if iSections > 2 {
            return 2
        }
        return iSections //3 //TODO We will remove this once we get the real apis
    }

    
    
    open func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 1 {
            if let spltMultiLevelChannel = self.channel as? SPLTMultiLevelChannel {
                return CGSize(width: collectionView.bounds.size.width, height: 100.0)
            } else if let playlistChannel = self.channel as? SPLTPlaylistChannel {
                return CGSize(width: collectionView.bounds.size.width, height: 50.0)
//                if playlistChannel.playlistVideos.count > 0 {
//                    return CGSize(width: collectionView.bounds.size.width, height: 100.0)
//                }
            }
        }
        return CGSize(width: 0.0, height: 0.0)
    }

    open func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if indexPath.section == 1 {
            switch kind {
            case UICollectionElementKindSectionHeader:
                if let dsIVPVideosSectionHeaderView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "DSIVPVideosSectionHeaderView", for: indexPath) as? DSIVPVideosSectionHeaderView {
                    dsIVPVideosSectionHeaderView.setCellData(self.channel)
                    return dsIVPVideosSectionHeaderView
                }
            default:
                fatalError("This should never happen!!")
            }
        }
        let uiCollectionReusableView = UICollectionReusableView(frame: CGRect.zero)
        return uiCollectionReusableView
    }

    
    
    override open func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        let iItems = super.collectionView(collectionView, numberOfItemsInSection: section)
        return iItems
    }
    
    // MARK: - size calculation
    open func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        switch indexPath.section {
            case 0: return self.getCurrentVideoDetailsCellSizeAt(indexPath)
            case 1: return self.getVideoDetailsCellSizeAt(indexPath)
            case 2: return self.getRecommendedVideoDetailsCellSizeAt(indexPath)
            default: return CGSize(width: 375.0, height: 100.0)
        }

//        return CGSize(width: UIScreen.main.bounds.width, height: 100)
//        let requiredWidth = collectionView.bounds.size.width
//        let targetSize = CGSize(width: requiredWidth, height: 0)
//        let cv = self.collectionView(collectionView, cellForItemAt: indexPath)
//        //        cv.setNeedsLayout()
//        let adequateSize = cv.systemLayoutSizeFitting(targetSize)
//        return adequateSize
//
    }
    
    open func getVideoAtIndexPath(_ indexPath: IndexPath) -> SPLTVideo? {
        if let spltMultiLevelChannel = self.channel as? SPLTMultiLevelChannel {
            if !self.isMoreEpisodesListHidden {
                if let curChildChannel = spltMultiLevelChannel.childChannels[self.iCurPlayingVideoSeasonIndex] as? SPLTVideoChannel {
                    if let video = curChildChannel.video {
                        return video
                    }
                }
            }
        }
        if let spltPlaylistChannel = self.channel as? SPLTPlaylistChannel {
            if indexPath.row < spltPlaylistChannel.playlistVideos.count {
                let video = spltPlaylistChannel.playlistVideos[indexPath.row]
                return video
            }
        }
        if let spltVideoChannel = self.channel as? SPLTVideoChannel {
            if let video = spltVideoChannel.video {
                return video
            }
        }
        return nil
    }
    
    open func getCurrentVideoDetailsCellSizeAt(_ indexPath: IndexPath) -> CGSize {
    //        var dsIVPCurrentVideoDetailCollectionViewCell_: DSIVPCurrentVideoDetailCollectionViewCell?
    //        if let dsIVPCurrentVideoDetailCollectionViewCell = self.offscreenCells["DSIVPCurrentVideoDetailCollectionViewCell"] as? DSIVPCurrentVideoDetailCollectionViewCell {
    //            dsIVPCurrentVideoDetailCollectionViewCell_ = dsIVPCurrentVideoDetailCollectionViewCell
    //        } else if let dsIVPCurrentVideoDetailCollectionViewCell = Bundle.main.loadNibNamed("DSIVPCurrentVideoDetailCollectionViewCell", owner: self, options: nil)?[0] as? DSIVPCurrentVideoDetailCollectionViewCell {
    //            dsIVPCurrentVideoDetailCollectionViewCell_ = dsIVPCurrentVideoDetailCollectionViewCell
    //            self.offscreenCells["DSIVPCurrentVideoDetailCollectionViewCell"] = dsIVPCurrentVideoDetailCollectionViewCell
    //        }
            
            let requiredWidth = self.view.frame.size.width
    //        let targetSize = CGSize(width: requiredWidth, height: 0)
            
    //        if let dsIVPCurrentVideoDetailCollectionViewCell = dsIVPCurrentVideoDetailCollectionViewCell_ {
    //            dsIVPCurrentVideoDetailCollectionViewCell.frame.size.width = requiredWidth
    //            dsIVPCurrentVideoDetailCollectionViewCell.constraintCellWidth?.constant = requiredWidth
    //            if let curVideo = self.curVideo {
    //                dsIVPCurrentVideoDetailCollectionViewCell.setCellData(curVideo,isExpanded: self.isCurrentVideoExpanded)
    //                dsIVPCurrentVideoDetailCollectionViewCell.setNeedsLayout()
    //                dsIVPCurrentVideoDetailCollectionViewCell.layoutIfNeeded()
    //                let adequateSize = dsIVPCurrentVideoDetailCollectionViewCell.systemLayoutSizeFitting(UILayoutFittingCompressedSize)
    //                return adequateSize
    //            }
    //        }
            
            if let video = self.getVideoAtIndexPath(indexPath) {
                var fontFuturaDescription = UIFont(name: "Arial", size: 14.0)!
    //            var iImageHeight: CGFloat = 64.0
                var topOffset: CGFloat = 100.0
                var extraOffset: CGFloat = 20.0
                var labelDescriptionWidth = self.view.frame.size.width - 50
                if UIDevice.current.userInterfaceIdiom == .pad {
                    fontFuturaDescription = UIFont(name: "Arial", size: 21.0)!
                    topOffset = 150.0
                    extraOffset = 40.0
                    labelDescriptionWidth = self.view.frame.size.width - 100
                }
                let attributes = [NSAttributedString.Key.font: fontFuturaDescription]
                // 15.0 for iPHone , 30.0 for iPad  gap 5px top of image, bottom of image, bottom of description
                // 20 offset
                if self.isCurrentVideoExpanded {
                    var adequateSize = CGSize(width: requiredWidth, height: topOffset + 30.0 + extraOffset)
                    if let strDescription = video.strDescription {
                        let labelDescriptionMaxSize = CGSize(width: labelDescriptionWidth, height: 1000)
                        let estimatedFrame = NSString(string: strDescription).boundingRect(with: labelDescriptionMaxSize, options: .usesLineFragmentOrigin, attributes: attributes, context: nil)
                        if self.isCurrentVideoExpanded { //video.isExpandedUI {
                            adequateSize = CGSize(width: requiredWidth, height: estimatedFrame.height + topOffset + 20 ) //+ extraOffset) // 50 extra offset
                        }
                    }
                    return adequateSize
                } else {
                    let adequateSize = CGSize(width: requiredWidth, height: topOffset + 15.0 + extraOffset)
                    return adequateSize
                }
    //            return adequateSize
            }
            
            
            
            return CGSize(width: 375.0, height: 100.0)
        }
    
    func getVideoDetailsCellSizeAt(_ indexPath: IndexPath) -> CGSize {
            let requiredWidth = self.view.frame.size.width
    //        if let spltPlaylistChannel = self.channel as? SPLTPlaylistChannel {
    //            if indexPath.row < spltPlaylistChannel.playlistVideos.count {
    //                let video = spltPlaylistChannel.playlistVideos[indexPath.row]
            if let video = self.getVideoAtIndexPath(indexPath) {
                    var fontFuturaDescription = UIFont(name: "HelveticaNeue", size: 12.0)!
                    var iImageHeight: CGFloat = 64.0
                    var extraOffset: CGFloat = 10.0
                    var labelDescriptionWidth = self.view.frame.size.width - 150
                    if UIDevice.current.userInterfaceIdiom == .pad {
                        fontFuturaDescription = UIFont(name: "HelveticaNeue", size: 18.0)!
                        iImageHeight = 128.0
                        extraOffset = 20.0
                        labelDescriptionWidth = self.view.frame.size.width - 200
                    }
                let attributes = [NSAttributedString.Key.font: fontFuturaDescription]
                    // 15.0 for iPHone , 30.0 for iPad  gap 5px top of image, bottom of image, bottom of description
                    // 20 offset
                    var adequateSize = CGSize(width: requiredWidth, height: iImageHeight + 15.0 + extraOffset)
                    if let strDescription = video.strDescription {
                        let labelDescriptionMaxSize = CGSize(width: labelDescriptionWidth, height: 1000)


                        let estimatedFrame = NSString(string: strDescription).boundingRect(with: labelDescriptionMaxSize, options: .usesLineFragmentOrigin, attributes: attributes, context: nil)
                        if video.isExpandedUI {
                            adequateSize = CGSize(width: requiredWidth, height: estimatedFrame.height + iImageHeight + extraOffset)//+ 30.0 + extraOffset) // 50 extra offset
                        }
                    }

                    return adequateSize
            }
    //            }
    //        }
            return CGSize(width: 375.0, height: 100.0)
        }

    func getRecommendedVideoDetailsCellSizeAt(_ indexPath: IndexPath) -> CGSize {
        let collectionViewNumberOfColumns = 2
        let collectionViewItemSpacing = 10.0
        var collectionViewItemWidth = self.view.frame.width - (CGFloat(collectionViewNumberOfColumns + 1) * CGFloat(collectionViewItemSpacing))
        collectionViewItemWidth = collectionViewItemWidth / CGFloat(collectionViewNumberOfColumns)
        collectionViewItemWidth = floor(collectionViewItemWidth)
        var collectionViewItemHeight = collectionViewItemWidth * 9 / 16
        collectionViewItemHeight = ceil(collectionViewItemHeight)
        let size = CGSize(width: collectionViewItemWidth, height: collectionViewItemHeight)
        return size
        
    }
    
    //TODO We will remove this once we get the real apis
    override open func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
            case 0: return self.getCurrentVideoDetailsCell(collectionView, cellForItemAt: indexPath)
            case 1: return self.getVideoDetailsCell(collectionView, cellForItemAt: indexPath)
            case 2: return self.getRecommendedVideoDetailsCell(collectionView, cellForItemAt: indexPath)
            default: return UICollectionViewCell()
        }
    }
    
    open func getCurrentVideoDetailsCell(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let dsIVPCurrentVideoDetailCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "DSIVPCurrentVideoDetailCollectionViewCell", for: indexPath) as? DSIVPCurrentVideoDetailCollectionViewCell {
            dsIVPCurrentVideoDetailCollectionViewCell.delegate = self
            if let curVideo = self.curVideo {
                dsIVPCurrentVideoDetailCollectionViewCell.setCellData(curVideo,isExpanded: self.isCurrentVideoExpanded)
            }
            return dsIVPCurrentVideoDetailCollectionViewCell
        }
        return UICollectionViewCell()
    }
    
    func getVideoDetailsCell(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let dsIVPVideoDetailCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "DSIVPVideoDetailCollectionViewCell", for: indexPath) as? DSIVPVideoDetailCollectionViewCell {
            dsIVPVideoDetailCollectionViewCell.delegate = self

            if let spltMultiLevelChannel = self.channel as? SPLTMultiLevelChannel {
                if !self.isMoreEpisodesListHidden {
                    if let curChildChannel = spltMultiLevelChannel.childChannels[self.iCurPlayingVideoSeasonIndex] as? SPLTVideoChannel {
                        if let video = curChildChannel.video {
                            dsIVPVideoDetailCollectionViewCell.setCellData(video, isCurVideoPlaying: true)
                            return dsIVPVideoDetailCollectionViewCell
                        }
                    }
                }
            }
            
            if let spltPlaylistChannel = self.channel as? SPLTPlaylistChannel {
                if indexPath.row < spltPlaylistChannel.playlistVideos.count {
                    let video = spltPlaylistChannel.playlistVideos[indexPath.row]
                    if self.iCurVideoIndex == indexPath.row {
                        dsIVPVideoDetailCollectionViewCell.setCellData(video, isCurVideoPlaying: true)
                    } else {
                        dsIVPVideoDetailCollectionViewCell.setCellData(video, isCurVideoPlaying: false)
                    }
//                    dsIVPVideoDetailCollectionViewCell.setCellData(video)
                }
            }
            return dsIVPVideoDetailCollectionViewCell
        }
        return UICollectionViewCell()
    }
    
    func getRecommendedVideoDetailsCell(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let dsIVPRecommendedVideoDetailCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "DSIVPRecommendedVideoDetailCollectionViewCell", for: indexPath) as? DSIVPRecommendedVideoDetailCollectionViewCell {
            dsIVPRecommendedVideoDetailCollectionViewCell.imageKey = "poster"
            if indexPath.row < self.recommendationChannels.count {
                let channel = self.recommendationChannels[indexPath.row]
                let size = self.getRecommendedVideoDetailsCellSizeAt(indexPath)
                dsIVPRecommendedVideoDetailCollectionViewCell.setCellChannelData(channel, collectionViewImageSize: size)
            }
            return dsIVPRecommendedVideoDetailCollectionViewCell
        }
        return UICollectionViewCell()
    }
    
    override open func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            self.isCurrentVideoExpanded = !self.isCurrentVideoExpanded
            self.reloadAllUI()
        }
    }
    

}

//MARK: - DSIVPVideoDetailTableViewCellDelegate methods
extension DSIVPMultiSeriesChannelViewController: DSIVPVideoDetailCollectionViewCellDelegate {
    public func didClickExpandButton(_ dsIVPVideoDetailTableViewCell: DSIVPVideoDetailCollectionViewCell) {
        if let indexPath = self.collectionView?.indexPath(for: dsIVPVideoDetailTableViewCell) {
            if indexPath.section == 1 {
                if let spltPlaylistChannel = self.channel as? SPLTPlaylistChannel {
                    if indexPath.row < spltPlaylistChannel.playlistVideos.count {
                        let video = spltPlaylistChannel.playlistVideos[indexPath.row]
                        video.isExpandedUI = !video.isExpandedUI
                        //dsIVPVideoDetailsCell.updateUI()
                        self.reloadAllUI()
                    }
                }
            }
        }
    }
}

//MARK: - DotstudioIMAPlayerViewControllerDelegate methods
extension DSIVPMultiSeriesChannelViewController: DSPPlayerViewControllerDelegate, DSIVPCurrentVideoDetailCollectionViewCellDelegate {
    public func didClickShareButton(_ dsIVPCurrentVideoDetailCollectionViewCell: DSIVPCurrentVideoDetailCollectionViewCell, sender: UIButton) {
        
    }
    
    public func didClickCastButton(_ dsIVPCurrentVideoDetailCollectionViewCell: DSIVPCurrentVideoDetailCollectionViewCell, sender: UIButton) {
        
    }
    
    
    public func didClickCloseButton(_ dspPlayerViewController: DSPPlayerViewController) {
        self.delegate?.didClickCloseButton(self)
    }
    
    public func didClickCastButton(_ dspPlayerViewController: DSPPlayerViewController) {
        
    }
    
    public func didClickShareButton(_ dspPlayerViewController: DSPPlayerViewController) {
        
    }
    
    public func didClickShareButtonWithSender(_ dspPlayerViewController: DSPPlayerViewController, sender: UIButton) {
        
    }
    
    public func didFinishPlayingVideo(_ dspPlayerViewController: DSPPlayerViewController) {
        
    }
    
    public func didClickViewSchedule(curVideo: SPLTVideo) {
        
    }
    
    public func didClickCloseButton(sender: Any) {
        self.delegate?.didClickCloseButton(self)
    }
    public func didClickCastButton(sender: Any) {
        
    }
    public func didClickShareButton(sender: Any) {
        
    }
}
