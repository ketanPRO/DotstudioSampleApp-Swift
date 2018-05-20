//
//  SPLTIVPMultiSeriesChannelViewController.swift
//  DotstudioUI-iOS
//
//  Created by Anwer on 5/17/18.
//

import UIKit
import DotstudioAPI

open class SPLTIVPMultiSeriesChannelViewController: SPLTIVPSeriesChannelViewController {

    open var iCurVideoSeasonIndex = 0

    open override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override open func setCurrentVideo() {
        if let spltMultiLevelChannel = self.channel as? SPLTMultiLevelChannel {
            if let playlistChannel = spltMultiLevelChannel.childChannels[self.iCurVideoSeasonIndex] as? SPLTPlaylistChannel {
                if (self.iCurVideoIndex < playlistChannel.playlistVideos.count) {
                    let curVideo = playlistChannel.playlistVideos[self.iCurVideoIndex]
                    self.setCurrentVideo(curVideo: curVideo)
                }
            }
        } else {
            super.setCurrentVideo()
        }
    }
    
    override open func reloadAllData() {
        super.reloadAllData()
//        if let spltMultiLevelChannel = self.channel as? SPLTMultiLevelChannel {
//            self.viewChannelVCPlaylistHeader.spltMultiLevelChannel = spltMultiLevelChannel
//        }
    }
    
    
    override open func requestChannel() {
        
        if let spltCustomPlaylistChannel = self.channel as? SPLTCustomPlaylistChannel {
            self.reloadAllData()
            self.reloadAllUI()
        } else if let strChannelSlug = self.strChannelSlug {
            self.showProgress()
            SPLTChannelAPI().getPartialChannel(strChannelSlug, completion: { (channelDict) in
                if let retrieviedChannel = SPLTChannel.getChannelFromChannelDict(channelDict) {
                    self.channel = retrieviedChannel
                    if let spltMultiLevelChannel = retrieviedChannel as? SPLTMultiLevelChannel {
                        self.requestFullChannelForMultiLevelChannel(spltMultiLevelChannel)
                    } else {
                        super.requestChannel()
                    }
                } else {
                    self.hideProgress()
                }
            }, completionError: { (error) in
                self.hideProgress()
            })
        } else if let spltMultiLevelChannel = self.channel as? SPLTMultiLevelChannel {
            self.showProgress()
            spltMultiLevelChannel.loadPartialChannel({ (dictChannel) in
                spltMultiLevelChannel.mapFromChannelDict(dictChannel)
                self.requestFullChannelForMultiLevelChannel(spltMultiLevelChannel)
            }, completionErrorChannel: { (error) in
                print(error.debugDescription)
                self.hideProgress()
            })
        } else {
            super.requestChannel()
        }
    }
    
    open func requestFullChannelForMultiLevelChannel(_ spltMultiLevelChannel: SPLTMultiLevelChannel) {
        for (index,childChannel) in spltMultiLevelChannel.childChannels.enumerated() {
            childChannel.loadFullChannel({ (dictChildChannel) in
                // loaded child channel.
                if index == 0 {
                    spltMultiLevelChannel.iCurChildChannelIndex = 0
                }
                self.reloadAllData()
                self.reloadAllUI()
                self.hideProgress()
            }, completionError: { (error) in
                // Error while loading child channel
                self.hideProgress()
                self.closeViewController()
            })
            break
        }
    }
    
    open func updateCurSeason(_ iCurSeasonNo: Int) {
        if let spltMultiLevelChannel = self.channel as? SPLTMultiLevelChannel {
            spltMultiLevelChannel.iCurChildChannelIndex = iCurSeasonNo
            //self.reloadAllData()
//            self.tableView.beginUpdates()
//            self.tableView.reloadSections([1], with: .automatic)
//            self.tableView.endUpdates()
            self.reloadAllUI()
//            self.viewChannelVCPlaylistHeader.updateUI()
        }
    }
    
    override open func playNextVideo() {
        if let multiLevelChannel = self.channel as? SPLTMultiLevelChannel {
            //self.iCurVideoSeasonIndex
            if let playlistChannel = multiLevelChannel.childChannels[self.iCurVideoSeasonIndex] as? SPLTPlaylistChannel {
                if ((self.iCurVideoIndex + 1) < playlistChannel.playlistVideos.count) {
//                    let prevIndexPath = IndexPath(row: self.iCurVideoIndex, section: 1)
                    self.iCurVideoIndex = self.iCurVideoIndex + 1
//                    let nextIndexPath = IndexPath(row: self.iCurVideoIndex, section: 1)
//                    let videoDetailIndexPath = IndexPath(row: 0, section: 0)
                    self.setCurrentVideo()
                    self.reloadAllUI()
                    //                    self.tableView.beginUpdates()
                    //                    self.tableView.reloadRows(at: [videoDetailIndexPath,prevIndexPath,nextIndexPath], with: .automatic)
                    //                    self.tableView.endUpdates()
                }
            }
        } else {
            super.playNextVideo()
        }
    }
    
    
    
    //MARK: -
    //MARK: - UICollectionViewDataSource methods
    
    open override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // for channel episodes list
        if indexPath.section == 1 {
            return UICollectionViewCell()
        }
        return super.collectionView(collectionView, cellForItemAt: indexPath)
        
    }
}
