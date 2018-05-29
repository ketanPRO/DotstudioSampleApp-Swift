//
//  DSIVPMultiSeriesChannelViewController.swift
//  DotstudioSampleApp-iOS
//
//  Created by Anwer on 5/17/18.
//  Copyright © 2018 Dotstudioz. All rights reserved.
//

import UIKit
import DotstudioUI
import DotstudioAPI
import DotstudioIMAPlayer

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
    var dotstudioIMAPlayerViewController: DotstudioIMAPlayerViewController?
    var offscreenCells: [String: Any] = [:]

    override open func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        if let dotstudioIMAPlayerViewController = DotstudioIMAPlayerViewController.getSPLTViewController() as? DotstudioIMAPlayerViewController {
            dotstudioIMAPlayerViewController.delegate = self
            self.dotstudioIMAPlayerViewController = dotstudioIMAPlayerViewController
            self.splt_configureChildViewController(childController: dotstudioIMAPlayerViewController, onView: self.viewDotstudioIMAPlayer)
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
        self.dotstudioIMAPlayerViewController?.setCurrentVideo(curVideo: curVideo)
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

    
    
    open override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
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
    open override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
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
    
    open func getCurrentVideoDetailsCellSizeAt(_ indexPath: IndexPath) -> CGSize {
        var dsIVPCurrentVideoDetailTableViewCell_: DSIVPCurrentVideoDetailTableViewCell?
        if let dsIVPCurrentVideoDetailTableViewCell = self.offscreenCells["DSIVPCurrentVideoDetailTableViewCell"] as? DSIVPCurrentVideoDetailTableViewCell {
            dsIVPCurrentVideoDetailTableViewCell_ = dsIVPCurrentVideoDetailTableViewCell
        } else if let dsIVPCurrentVideoDetailTableViewCell = Bundle.main.loadNibNamed("DSIVPCurrentVideoDetailTableViewCell", owner: self, options: nil)?[0] as? DSIVPCurrentVideoDetailTableViewCell {
            dsIVPCurrentVideoDetailTableViewCell_ = dsIVPCurrentVideoDetailTableViewCell
            self.offscreenCells["DSIVPCurrentVideoDetailTableViewCell"] = dsIVPCurrentVideoDetailTableViewCell
        }
        
        let requiredWidth = self.view.frame.size.width
        let targetSize = CGSize(width: requiredWidth, height: 0)
        
        if let dsIVPCurrentVideoDetailTableViewCell = dsIVPCurrentVideoDetailTableViewCell_ {
            if let curVideo = self.curVideo {
                dsIVPCurrentVideoDetailTableViewCell.setCellData(curVideo,isExpanded: self.isCurrentVideoExpanded)
                
                let adequateSize = dsIVPCurrentVideoDetailTableViewCell.systemLayoutSizeFitting(targetSize)
                return adequateSize
            }
        }
        return CGSize(width: 375.0, height: 100.0)
    }
    
    func getVideoDetailsCellSizeAt(_ indexPath: IndexPath) -> CGSize {
        var dsIVPVideoDetailTableViewCell_: DSIVPVideoDetailTableViewCell?
        if let dsIVPVideoDetailTableViewCell = self.offscreenCells["DSIVPVideoDetailTableViewCell"] as? DSIVPVideoDetailTableViewCell {
            dsIVPVideoDetailTableViewCell_ = dsIVPVideoDetailTableViewCell
        } else if let dsIVPVideoDetailTableViewCell = Bundle.main.loadNibNamed("DSIVPVideoDetailTableViewCell", owner: self, options: nil)?[0] as? DSIVPVideoDetailTableViewCell {
            dsIVPVideoDetailTableViewCell_ = dsIVPVideoDetailTableViewCell
            self.offscreenCells["DSIVPVideoDetailTableViewCell"] = dsIVPVideoDetailTableViewCell
        }
        let requiredWidth = self.view.frame.size.width
        let targetSize = CGSize(width: requiredWidth, height: 0)
        if let dsIVPVideoDetailTableViewCell = dsIVPVideoDetailTableViewCell_ {
            if let spltPlaylistChannel = self.channel as? SPLTPlaylistChannel {
                if indexPath.row < spltPlaylistChannel.playlistVideos.count {
                    let video = spltPlaylistChannel.playlistVideos[indexPath.row]
                    dsIVPVideoDetailTableViewCell.setCellData(video)
                    let adequateSize = dsIVPVideoDetailTableViewCell.systemLayoutSizeFitting(targetSize)
                    return adequateSize
                }
            }
        }
        return CGSize(width: 375.0, height: 100.0)
    }

    func getRecommendedVideoDetailsCellSizeAt(_ indexPath: IndexPath) -> CGSize {
        var dsIVPRecommendedVideoDetailTableViewCell_: DSIVPRecommendedVideoDetailTableViewCell?
        if let dsIVPRecommendedVideoDetailTableViewCell = self.offscreenCells["DSIVPRecommendedVideoDetailTableViewCell"] as? DSIVPRecommendedVideoDetailTableViewCell {
            dsIVPRecommendedVideoDetailTableViewCell_ = dsIVPRecommendedVideoDetailTableViewCell
        } else if let dsIVPRecommendedVideoDetailTableViewCell = Bundle.main.loadNibNamed("DSIVPRecommendedVideoDetailTableViewCell", owner: self, options: nil)?[0] as? DSIVPRecommendedVideoDetailTableViewCell {
            dsIVPRecommendedVideoDetailTableViewCell_ = dsIVPRecommendedVideoDetailTableViewCell
            self.offscreenCells["DSIVPRecommendedVideoDetailTableViewCell"] = dsIVPRecommendedVideoDetailTableViewCell
        }
        if let dsIVPRecommendedVideoDetailTableViewCell = dsIVPRecommendedVideoDetailTableViewCell_ {
            if indexPath.row < self.recommendationVideos.count {
                let video = self.recommendationVideos[indexPath.row]
                dsIVPRecommendedVideoDetailTableViewCell.setCellData(video)
                
                var collectionViewItemWidth = self.view.frame.width - (CGFloat(3) * CGFloat(10))
                collectionViewItemWidth = collectionViewItemWidth / CGFloat(2)
                let targetSize = CGSize(width: collectionViewItemWidth, height: 0)
                let adequateSize = dsIVPRecommendedVideoDetailTableViewCell.systemLayoutSizeFitting(targetSize)
                return adequateSize

            }
        }
        return CGSize(width: 375.0, height: 100.0)
    }
    
    //TODO We will remove this once we get the real apis
    override open func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
            case 0: return self.getCurrentVideoDetailsCell(collectionView, cellForItemAt: indexPath)
            case 1: return self.getVideoDetailsCell(collectionView, cellForItemAt: indexPath)
            case 2: return self.getRecommendedVideoDetailsCell(collectionView, cellForItemAt: indexPath)
            default: return UICollectionViewCell()
        }
        return UICollectionViewCell()
    }
    
    open func getCurrentVideoDetailsCell(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let dsIVPCurrentVideoDetailTableViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "DSIVPCurrentVideoDetailTableViewCell", for: indexPath) as? DSIVPCurrentVideoDetailTableViewCell {
            if let curVideo = self.curVideo {
                dsIVPCurrentVideoDetailTableViewCell.setCellData(curVideo,isExpanded: self.isCurrentVideoExpanded)
            }
            return dsIVPCurrentVideoDetailTableViewCell
        }
        return UICollectionViewCell()
    }
    func getVideoDetailsCell(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let dsIVPVideoDetailTableViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "DSIVPVideoDetailTableViewCell", for: indexPath) as? DSIVPVideoDetailTableViewCell {
            if let spltPlaylistChannel = self.channel as? SPLTPlaylistChannel {
                if indexPath.row < spltPlaylistChannel.playlistVideos.count {
                    let video = spltPlaylistChannel.playlistVideos[indexPath.row]
                    dsIVPVideoDetailTableViewCell.setCellData(video)
                }
            }
            dsIVPVideoDetailTableViewCell.delegate = self
            return dsIVPVideoDetailTableViewCell
        }
        return UICollectionViewCell()
    }
    func getRecommendedVideoDetailsCell(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let dsIVPRecommendedVideoDetailTableViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "DSIVPRecommendedVideoDetailTableViewCell", for: indexPath) as? DSIVPRecommendedVideoDetailTableViewCell {
            
            if indexPath.row < self.recommendationVideos.count {
                let video = self.recommendationVideos[indexPath.row]
                dsIVPRecommendedVideoDetailTableViewCell.setCellData(video)
            }
            var collectionViewItemWidth = self.view.frame.width - (CGFloat(3) * CGFloat(10))
            collectionViewItemWidth = collectionViewItemWidth / CGFloat(2)
            return dsIVPRecommendedVideoDetailTableViewCell
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
extension DSIVPMultiSeriesChannelViewController: DSIVPVideoDetailTableViewCellDelegate {
    public func didClickExpandButton(_ dsIVPVideoDetailTableViewCell: DSIVPVideoDetailTableViewCell) {
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
extension DSIVPMultiSeriesChannelViewController: DotstudioIMAPlayerViewControllerDelegate {
    public func didClickCloseButton(sender: Any) {
        self.delegate?.didClickCloseButton(self)
    }
    public func didClickCastButton(sender: Any) {
        
    }
    public func didClickShareButton(sender: Any) {
        
    }
}



