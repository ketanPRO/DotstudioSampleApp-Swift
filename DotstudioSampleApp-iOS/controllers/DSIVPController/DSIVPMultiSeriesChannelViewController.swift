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

open class DSIVPMultiSeriesChannelViewController: SPLTIVPMultiSeriesChannelViewController {
    @IBOutlet weak open override var collectionView: UICollectionView? {
        get {
            return super.collectionView
        }
        set {
            
            super.collectionView = newValue
        }
    }
    var isCurrentVideoExpanded:Bool = false
    

    override open func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.collectionView?.register(UINib(nibName: "DSIVPCurrentVideoDetailsCell", bundle: nil), forCellWithReuseIdentifier: "DSIVPCurrentVideoDetailsCell")
        self.collectionView?.register(UINib(nibName: "DSIVPVideoDetailsCell", bundle: nil), forCellWithReuseIdentifier: "DSIVPVideoDetailsCell")
        self.collectionView?.register(UINib(nibName: "DSIVPRecommendedVideoDetailsCell", bundle: nil), forCellWithReuseIdentifier: "DSIVPRecommendedVideoDetailsCell")
        self.collectionView?.register(UINib(nibName: "DSIVPVideosSectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "DSIVPVideosSectionHeaderView")
        
        self.resetCollectionViewSize()
    }
    
    open override func requestChannel() {
        super.requestChannel()
    }
    open override func reloadAllData() {
        super.reloadAllData()
    }
    
    func resetCollectionViewSize() {
        if let collectionView = self.collectionView {
            if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
//                flowLayout.minimumLineSpacing = CGFloat(10)
//                flowLayout.minimumInteritemSpacing = CGFloat(10)
//                flowLayout.sectionInset = UIEdgeInsetsMake(CGFloat(10), 0, CGFloat(10), 0)
                if #available(iOS 10.0, *) {
                    flowLayout.estimatedItemSize = UICollectionViewFlowLayoutAutomaticSize //CGSize(width: collectionView.frame.size.width, height: 120.0) //UICollectionViewFlowLayoutAutomaticSize
                } else {
                    // Fallback on earlier versions
                    flowLayout.estimatedItemSize = CGSize(width: collectionView.frame.size.width, height: 120.0)
                }

            }
        }
        
        
        
    }

    //MARK: - UICollectionViewDataSource methods
   
    /*func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        switch section {
        case 1: return CGSize(width: collectionView.frame.size.width, height:100)
        default: return CGSize(width: collectionView.frame.size.width, height:0)
        }
    }
*/
    
    open func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if indexPath.section == 1 {
            switch kind {
            case UICollectionElementKindSectionHeader:
                let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                             withReuseIdentifier: "DSIVPVideosSectionHeaderView",
                                                                             for: indexPath) as! DSIVPVideosSectionHeaderView
                return headerView
            default:
                fatalError("This should never happen!!")
            }
        }else{
            let uiCollectionReusableView = UICollectionReusableView(frame: CGRect.zero)
            return uiCollectionReusableView
        }
    }

    
    /*
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        switch indexPath.section {
            case 1: return CGSize(width: (self.collectionView?.frame.size.width)!, height: 140.0)
        case 2: do {
                var collectionViewItemWidth = self.view.frame.width - (CGFloat(3) * CGFloat(10))
                collectionViewItemWidth = collectionViewItemWidth / CGFloat(2)
                let collectionViewItemHeight = collectionViewItemWidth*9/16
                return CGSize(width: collectionViewItemWidth, height: collectionViewItemHeight+40)
            }
            default: return CGSize(width: (self.collectionView?.frame.size.width)!, height: 120.0)
        }
    }*/
    
    override open func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        let iSections = super.numberOfSections(in: collectionView)
        return iSections //3 //TODO We will remove this once we get the real apis
    }
    
    override open func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        let iItems = super.collectionView(collectionView, numberOfItemsInSection: section)
        if iItems > 0 {
            print("itesm more than 1")
        }
        
//        if section == 1 {
//            if let playlistChannel = self.channel as? SPLTPlaylistChannel {
//                if !self.isMoreEpisodesListHidden {
//                    return playlistChannel.playlistVideos.count
//                }
//            }
//            return 0
//        }
        return iItems
    }
    
    //TODO We will remove this once we get the real apis
    override open func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        print(indexPath.section)
        switch indexPath.section {
            case 0: return self.getCurrentVideoDetailsCell(collectionView, cellForItemAt: indexPath)
            case 1: return self.getVideoDetailsCell(collectionView, cellForItemAt: indexPath)
            case 2: return self.getRecommendedVideoDetailsCell(collectionView, cellForItemAt: indexPath)
            default: return UICollectionViewCell()
        }
        return UICollectionViewCell()
    }
    
    open func getCurrentVideoDetailsCell(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let dsIVPCurrentVideoDetailsCell = collectionView.dequeueReusableCell(withReuseIdentifier: "DSIVPCurrentVideoDetailsCell", for: indexPath) as! DSIVPCurrentVideoDetailsCell
        if let curVideo = self.curVideo {
            dsIVPCurrentVideoDetailsCell.setCellData(curVideo,isExpanded: self.isCurrentVideoExpanded)
        }
//        dsIVPCurrentVideoDetailsCell.constraintDiscriptionWidth?.constant = CGFloat(collectionView.frame.size.width-20)
        return dsIVPCurrentVideoDetailsCell
    }
    func getVideoDetailsCell(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let dsIVPVideoDetailsCell = collectionView.dequeueReusableCell(withReuseIdentifier: "DSIVPVideoDetailsCell", for: indexPath) as? DSIVPVideoDetailsCell {
            if let spltPlaylistChannel = self.channel as? SPLTPlaylistChannel {
                if indexPath.row < spltPlaylistChannel.playlistVideos.count {
                    let video = spltPlaylistChannel.playlistVideos[indexPath.row]
                    dsIVPVideoDetailsCell.setCellData(video)
                }
            }
            dsIVPVideoDetailsCell.delegate = self
//            dsIVPVideoDetailsCell.constraintDiscriptionWidth?.constant = CGFloat(collectionView.frame.size.width-38)
            return dsIVPVideoDetailsCell
        }
        return UICollectionViewCell()
    }
    func getRecommendedVideoDetailsCell(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let dsIVPRecommendedVideoDetailsCell = collectionView.dequeueReusableCell(withReuseIdentifier: "DSIVPRecommendedVideoDetailsCell", for: indexPath) as? DSIVPRecommendedVideoDetailsCell {
            
            if indexPath.row < self.recommendationVideos.count {
                let video = self.recommendationVideos[indexPath.row]
                dsIVPRecommendedVideoDetailsCell.setCellData(video)
            }
            var collectionViewItemWidth = self.view.frame.width - (CGFloat(3) * CGFloat(10))
            collectionViewItemWidth = collectionViewItemWidth / CGFloat(2)
            dsIVPRecommendedVideoDetailsCell.constraintDiscriptionWidth?.constant = CGFloat(collectionViewItemWidth)
            return dsIVPRecommendedVideoDetailsCell
        }
        return UICollectionViewCell()
    }
    
    override open func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            self.isCurrentVideoExpanded = !self.isCurrentVideoExpanded
            self.reloadAllUI()
        }
    }
    
    open override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = super.collectionView(collectionView, layout: collectionViewLayout, sizeForItemAt: indexPath)
        if let collectionView = self.collectionView {
            let csize = CGSize(width: collectionView.frame.size.width, height: 120.0)
            return csize
//            if #available(iOS 10.0, *) {
//                return UICollectionViewFlowLayoutAutomaticSize
//            } else {
//                // Fallback on earlier versions
//                return csize
//            }
        }
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplaySupplementaryView view: UICollectionReusableView, forElementKind elementKind: String, at indexPath: IndexPath) {
        view.layer.zPosition = 0.0
    }
    open override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 1 {
            if let playlistChannel = self.channel as? SPLTPlaylistChannel {
                if playlistChannel.playlistVideos.count > 0 {
                    if UIDevice.current.userInterfaceIdiom == .pad {
                        return CGSize(width: 375.0, height: 80.0)
                    }
                    return CGSize(width: 375.0, height: 40.0)
                }
            }
            return CGSize(width: 0.0, height: 0.0)
        }
        return CGSize(width: 0.0, height: 0.0)
//        return super.collectionView(collectionView, layout: collectionViewLayout, referenceSizeForHeaderInSection: section)
    }
}

extension DSIVPMultiSeriesChannelViewController: DSIVPVideoDetailsCellDelegate {
    public func didClickExpandButton(_ dsIVPVideoDetailsCell: DSIVPVideoDetailsCell) {
        if let indexPath = self.collectionView?.indexPath(for: dsIVPVideoDetailsCell) {
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



