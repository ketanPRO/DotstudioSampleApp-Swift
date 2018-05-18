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

//TODO We will remove this once we get the real apis
extension SPLTVideo {
    class func getDummyVideo() -> SPLTVideo {
        let video = SPLTVideo()
        video.strTitle = "Video Title"
        video.strSeriesTitle = "Series Title"
        video.strVideoInfo = "Info"
        video.strDescription = "We have a subclass for our cell, now let's create the view controller class. Inside the viewDidLoad method you have to set the estimatedItemSize property on the collection view. There if you give wrong size, the autorotation won't work as expected."
        video.thumb = "http://via.placeholder.com/320x180"
        video.progressPoint = 70
        video.iDuration = 400
        return video
    }
}

protocol MultiSeriesChannelDelegate: class {
    func reloadCollectionViewData()
}

class DSIVPMultiSeriesChannelViewController: UIViewController, MultiSeriesChannelDelegate {
    @IBOutlet weak var collectionView: UICollectionView?
    var isCurrentVideoExpanded:Bool = false
    

    func reloadCollectionViewData() {
        self.collectionView?.collectionViewLayout.invalidateLayout()
        self.collectionView?.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.collectionView?.register(UINib(nibName: "DSIVPCurrentVideoDetailsCell", bundle: nil), forCellWithReuseIdentifier: "DSIVPCurrentVideoDetailsCell")
        self.collectionView?.register(UINib(nibName: "DSIVPVideoDetailsCell", bundle: nil), forCellWithReuseIdentifier: "DSIVPVideoDetailsCell")
        self.collectionView?.register(UINib(nibName: "DSIVPRecommendedVideoDetailsCell", bundle: nil), forCellWithReuseIdentifier: "DSIVPRecommendedVideoDetailsCell")
        self.collectionView?.register(UINib(nibName: "DSIVPVideosSectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "DSIVPVideosSectionHeaderView")
        
        self.resetCollectionViewSize()
    }
    
    func resetCollectionViewSize() {
        if let flowLayout = self.collectionView!.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.minimumLineSpacing = CGFloat(10)
            flowLayout.minimumInteritemSpacing = CGFloat(10)
            flowLayout.sectionInset = UIEdgeInsetsMake(CGFloat(10), 0, CGFloat(10), 0)
            if #available(iOS 10.0, *) {
                flowLayout.estimatedItemSize = UICollectionViewFlowLayoutAutomaticSize
            } else {
                // Fallback on earlier versions
                flowLayout.estimatedItemSize = CGSize(width: CGFloat((self.collectionView?.frame.size.width)!), height: 120)
            }

        }
    }
}

extension DSIVPMultiSeriesChannelViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
   
    /*func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        switch section {
        case 1: return CGSize(width: collectionView.frame.size.width, height:100)
        default: return CGSize(width: collectionView.frame.size.width, height:0)
        }
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
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
            return UICollectionReusableView()
        }
    }*/

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
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3 //TODO We will remove this once we get the real apis
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
            case 1: return 10 //TODO We will remove this once we get the real apis
            case 2: return 10
            default: return 1
        }
    }
    //TODO We will remove this once we get the real apis
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            if let videoDetailsCell = collectionView.dequeueReusableCell(withReuseIdentifier: "DSIVPCurrentVideoDetailsCell", for: indexPath) as? DSIVPCurrentVideoDetailsCell {
                videoDetailsCell.setCellData(SPLTVideo.getDummyVideo(),isExpanded: self.isCurrentVideoExpanded)
                if let collectionView = self.collectionView {
                    videoDetailsCell.discriptionWidthConstraint?.constant = CGFloat(collectionView.frame.size.width-20)
                }
                return videoDetailsCell
            }
            break
        case 1:
            if let videoDetailsCell = collectionView.dequeueReusableCell(withReuseIdentifier: "DSIVPVideoDetailsCell", for: indexPath) as? DSIVPVideoDetailsCell {
                videoDetailsCell.setCellData(SPLTVideo.getDummyVideo())
                videoDetailsCell.delegate = self
                if let collectionView = self.collectionView {
                    videoDetailsCell.discriptionWidthConstraint?.constant = CGFloat(collectionView.frame.size.width-38)
                }
                return videoDetailsCell
            }
            break
        case 2:
            if let videoDetailsCell = collectionView.dequeueReusableCell(withReuseIdentifier: "DSIVPRecommendedVideoDetailsCell", for: indexPath) as? DSIVPRecommendedVideoDetailsCell {
                videoDetailsCell.setCellData(SPLTVideo.getDummyVideo())
                var collectionViewItemWidth = self.view.frame.width - (CGFloat(3) * CGFloat(10))
                collectionViewItemWidth = collectionViewItemWidth / CGFloat(2)
                videoDetailsCell.discriptionWidthConstraint?.constant = CGFloat(collectionViewItemWidth)
                
                return videoDetailsCell
            }
            break
        default:
            if let videoDetailsCell = collectionView.dequeueReusableCell(withReuseIdentifier: "DSIVPCurrentVideoDetailsCell", for: indexPath) as? DSIVPCurrentVideoDetailsCell {
                videoDetailsCell.setCellData(SPLTVideo.getDummyVideo())
                if let collectionView = self.collectionView {
                    videoDetailsCell.discriptionWidthConstraint?.constant = CGFloat(collectionView.frame.size.width-38)
                }
                return videoDetailsCell
            }
            break
        }
        return UICollectionViewCell()
    }
}
extension DSIVPMultiSeriesChannelViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            self.isCurrentVideoExpanded = !self.isCurrentVideoExpanded
            self.reloadCollectionViewData()
        }
    }
    
}


