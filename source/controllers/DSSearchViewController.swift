//
//  DSSearchViewController.swift
//  DotstudioSampleApp-iOS
//
//  Created by Ketan Sakariya on 29/05/18.
//  Copyright © 2018 Dotstudioz. All rights reserved.
//

import Foundation
import UIKit
import DotstudioAPI
import DotstudioUI

protocol DSSearchViewControllerDelegate {
    func didSelectSearchVideo(video: SPLTVideo)
    func didSelectSearchChannel(channel: SPLTChannel)
}

class DSSearchViewController: SPLTSearchViewController {
    
//    var delegate: DSSearchViewControllerDelegate?
    @IBOutlet override weak var searchBar: UISearchBar? {
        get {
            return super.searchBar
        }
        set {
            
            super.searchBar = newValue
        }
    }
    @IBOutlet override weak var collectionView: UICollectionView? {
        get {
            return super.collectionView
        }
        set {
            
            super.collectionView = newValue
        }
    }
    @IBInspectable override open var collectionViewNumberOfColumns: Int {
        get {
            return super.collectionViewNumberOfColumns
        }
        set {
            super.collectionViewNumberOfColumns = newValue
        }
    }
    
    @IBInspectable override open var collectionViewItemSpacing: Int {
        get {
            return super.collectionViewItemSpacing
        }
        set {
            super.collectionViewItemSpacing = newValue
        }
    }
//    @IBOutlet override weak var constraintCollectionViewBottom: NSLayoutConstraint?
    
//    let spltSearchAPI = SPLTSearchAPI()
//    var videosDict: [[String: AnyObject]] = [[:]] {
//        didSet {
//            self.videos.removeAll()
//            for videoDict in videosDict {
//                let spltVideo = SPLTVideo(searchResultVideoDict: videoDict)
//                self.videos.append(spltVideo)
//            }
//        }
//    }
//    var videos: [SPLTVideo] = [] {
//        didSet {
//            //            self.collectionView?.reloadData()
//        }
//    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.searchType = .channel
        
        self.collectionView?.register(UINib(nibName: "DSGenericCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "DSGenericCollectionViewCell")


    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    

    
//    override func numberOfSections(in collectionView: UICollectionView) -> Int {
//        return 1
//    }
//    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return self.videos.count// + 1
//    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let genericCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "DSGenericCollectionViewCell", for: indexPath) as? DSGenericCollectionViewCell {
            
            switch self.searchType {
                case .channel:
                    if indexPath.row < self.channels.count {
                        let channel = self.channels[indexPath.row]
                        genericCollectionViewCell.setCellChannelData(channel, collectionViewImageSize: self.collectionViewImageSize)
                    }
                    break
                case .video:
                    if indexPath.row < self.videos.count {
                        let video = self.videos[indexPath.row]
                        genericCollectionViewCell.setCellVideoData(video, collectionViewImageSize: self.collectionViewImageSize)
                    }
                    break
            }
            
            return genericCollectionViewCell
        }
        return UICollectionViewCell()
    }

//MARK: -
//MARK: - extension UICollectionViewDelegate

//extension DSSearchViewController: UICollectionViewDelegate {
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            if let spltIVPPresentor = appDelegate.window?.rootViewController as? SPLTIVPPresentor {
                
                switch self.searchType {
                case .channel:
                    if indexPath.row < self.channels.count {
                        let channel = self.channels[indexPath.row]
                        spltIVPPresentor.openIVPViewControllerVideo(video: nil, in: channel, atAutoPlayIndex: nil, spltIVPViewControllerDelegate: nil)
                    }
                    break
                case .video:
                    if indexPath.row < self.videos.count {
                        let video = self.videos[indexPath.row]
                        spltIVPPresentor.openIVPViewControllerVideo(video: video, in: nil, atAutoPlayIndex: nil, spltIVPViewControllerDelegate: nil)
                    }
                    break
                }
            }
        }
        
        
//        if let storyboard = self.storyboard {
//            if let videoViewController = storyboard.instantiateViewController(withIdentifier: "DTSZVideoViewController") as? DTSZVideoViewController {
//                #if USE_NEW_CHANNEL_SCREEN
//                if indexPath.row < self.videos.count {
//                    let video = self.videos[indexPath.row]
//                    self.delegate?.didSelectSearchVideo(spltVideo: video)
//                }
//                #else
//                if indexPath.row < self.videos.count {
//                    let video = self.videos[indexPath.row]
//                    if let strVideoId = video.strId {
//                        let videoDetail: DTSZVideo = DTSZVideo(strVideoId: strVideoId)
//                        videoViewController.setVideoDetailFromSearch(videoDetail_: videoDetail)
//                        self.navigationController?.present(videoViewController, animated: true, completion: {
//                            
//                        })
//                    }
//                }
//                #endif
//                
//                
//            }
//        }
    }
    
    
}





