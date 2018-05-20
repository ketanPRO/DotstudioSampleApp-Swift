//
//  SPLTIVPChannelViewController.swift
//  DotstudioUI-iOS
//
//  Created by Anwer on 5/17/18.
//

import UIKit
import DotstudioAPI

open class SPLTIVPChannelViewController: SPLTIVPVideoViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak open var collectionView: UICollectionView?
    open var strChannelSlug: String?
    open var channel: SPLTChannel? {
        didSet {
            
        }
    }
    open var curChannel: SPLTChannel?
    open var recommendationVideos: [SPLTVideo] = []

    open override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.startLoadingData()
    }
    
    
    open func startLoadingData() {
        self.requestChannel()
    }
    open func requestChannel() {
        if let channel = self.channel {
            self.showProgress()
            channel.loadFullChannel({ (dictChannel) in
                print("channel loaded")
                self.reloadAllData()
//                self.collectionView?.reloadData()
                self.hideProgress()
            }, completionError: { (error) in
                print(error.debugDescription)
                self.hideProgress()
            })
        } else if let curVideo = self.curVideo {
            curVideo.loadFullVideo({ (dictVideo) in
                // received full video detail
                self.reloadAllData()
//                self.collectionView?.reloadData()
                self.hideProgress()
            }, completionError: { (error) in
                print("error while loading video")
            })
        }
    }
    
    open func loadChannelVideos() {
        if let channel = self.channel {
            channel.loadChannelVideos({ (bValue) in
                // completion
                self.reloadAllData()
                
                self.hideProgress()
            }, completionError: { (error) in
                // errror
                self.hideProgress()
            })
        } else {
            self.hideProgress()
        }
    }
    
    
    open func reloadAllData() {
        if self.channel == nil {
            if let curVideo = self.curVideo {
                self.setCurrentVideo(curVideo: curVideo)
            }
        }
        self.reloadAllUI()
    }
    
    open func reloadAllUI() {
        self.collectionView?.collectionViewLayout.invalidateLayout()
        self.collectionView?.reloadData()
    }
    
    //MARK:- set Player methods
    override open func setCurrentVideo(curVideo: SPLTVideo) {
        super.setCurrentVideo(curVideo: curVideo)
        self.setupRecommandationSection(curVideo: curVideo)
        self.reloadAllUI()
    }
    
    override open func getVmapAdTag(curVideo: SPLTVideo) -> String? {
        if let channel = self.channel {
            if let strVideoId = curVideo.strId, let strChannelId = channel.strId {
                let screenRect = UIScreen.main.bounds
                var screenWidth = Int(screenRect.width * UIScreen.main.scale)
                var screenHeight = Int(screenRect.height * UIScreen.main.scale)
                if screenRect.height > screenRect.width {
                    screenWidth = Int(screenRect.height * UIScreen.main.scale)
                    screenHeight = Int(screenRect.width * UIScreen.main.scale)
                }
                var adTagUrl = "https://api.myspotlight.tv/vmap/\(strVideoId)/\(screenWidth)/\(screenHeight)/\(strChannelId)"
                if let strVmapAdTagParameters = self.getVmapAdTagParameters() {
                    adTagUrl += "?\(strVmapAdTagParameters)"
                }
                return adTagUrl
                // For Test
                //return "http://dev.api.myspotlight.tv/vmap/57be8615d66da81809a33855/1855/1043/57be8615d66da81809a33855"
            }
        }
        return super.getVmapAdTag(curVideo: curVideo)
    }
    open func setupRecommandationSection(curVideo: SPLTVideo) {
        if let strVideoId = curVideo.strId {
            SPLTRecommandationAPI().getRecommandationForVideo(strVideoId, completion: { (recommandationDictArray) in
                // recommandation Dict
//                self.recommandationDictArray = recommandationDictArray
                self.reloadAllUI()
            }, completionError: { (error) in
                print("Error while loading recommandation for video")
            })
        }
    }

    
    
    
    
//MARK: -
//MARK: - UICollectionViewDataSource methods

//    open func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
//        return UICollectionReusableView()
//    }

    open func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    open func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 2 {
            let iTotalCount = Int(self.recommendationVideos.count)
            return iTotalCount
        }
        return 0
    }
    
    open func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
    
//MARK: -
//MARK: - UICollectionViewDelegateFlowLayout methods
    open func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: 0.0, height: 0.0)
    }
    open func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 0.0, height: 0.0)
    }
    
    open func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
}





