//
//  SPLTMultiLevelChannel.swift
//  DotstudioPRO
//
//  Created by Ketan Sakariya on 15/01/17.
//  Copyright © 2017 ___DotStudioz___. All rights reserved.
//

import Foundation

open class SPLTMultiLevelChannel: SPLTPlaylistChannel {
    
    
//    var childChannelDicts: [[String: AnyObject]] = [[:]] {
//        didSet {
//            
//        }
//    }
    var childChannels: [SPLTChannel] = []
    
//    var playlistDict: [[String: AnyObject]] = [[:]] {
//        didSet {
//            self.playlistVideos.removeAll()
//            for playlistVideo in playlistDict {
//                let spltVideo = SPLTVideo(videoDict: playlistVideo)
//                self.playlistVideos.append(spltVideo)
//            }
//            //            self.delegate?.didUpdateCategoryChannels()
//        }
//    }
//    override var playlistVideos: [SPLTVideo] {
//        get {
//        }
//    }
//    var playlist_id: String?
    
    var iCurChildChannelIndex: Int = 0 {
        didSet {
            if self.iCurChildChannelIndex < self.childChannels.count {
                if let playlistChannel = self.childChannels[self.iCurChildChannelIndex] as? SPLTPlaylistChannel {
                    self.playlistVideos = playlistChannel.playlistVideos
                }
            }
        }
    }
    
    override func mapFromChannelDict(_ channelDict: [String: AnyObject]) {
        super.mapFromChannelDict(channelDict)
        if let childChannelDicts = channelDict["childchannels"] as? [[String: AnyObject]] {
            self.childChannels.removeAll()
            for childChannelDict in childChannelDicts {
//                let spltChannel = SPLTPlaylistChannel(channelDict: childChannelDict)
                if let spltChannel = SPLTChannel.getChannelFromChannelDict(childChannelDict) {
                    self.childChannels.append(spltChannel)
                }
            }
            if self.childChannels.count > 0 {
                self.iCurChildChannelIndex = 0
            }
        }
//        if let playlistDict = channelDict["playlist"] as? [[String: AnyObject]] {
//            self.playlistDict = playlistDict
//        }
//        if let playlist_id = channelDict["playlist_id"] as? String {
//            self.playlist_id = playlist_id
//        }
    }
    
    override func isChannelVideosUpdated() -> Bool {
        return self.isMultiLevelChannelVideosUpdated()
    }
    override func loadChannelVideos(_ completion: @escaping (_ bSuccess: Bool) -> Void, completionError: @escaping (_ error: NSError) -> Void) {
        self.loadMultilevelChannelVideos(completion, completionError: completionError)
    }
    
}


////MARK: -
////MARK: - SPLTMultiLevelChannel Methods
extension SPLTMultiLevelChannel {
    func isMultiLevelChannelVideosUpdated() -> Bool {
        for childChannel in self.childChannels {
            if let playlistChannel = childChannel as? SPLTPlaylistChannel {
                for playlistVideo in playlistChannel.playlistVideos {
                    if playlistVideo.bVideoUpdated == false {
                        return false
                    }
                }
            }
        }
        return true
    }
    func loadMultilevelChannelVideos(_ completion: @escaping (_ bSuccess: Bool) -> Void, completionError: (_ error: NSError) -> Void) {
        var iTotalCallComplete: Int = 0
        var iTotalMultilevelChannelVideos = 0
        for childChannel in self.childChannels {
            if let playlistChannel = childChannel as? SPLTPlaylistChannel {
                for playlistVideo in playlistChannel.playlistVideos {
                    iTotalMultilevelChannelVideos += 1
                    playlistVideo.loadPlaylistVideo({ (videoDict) in
                        // success
                        iTotalCallComplete += 1
                        if self.isMultiLevelChannelVideosUpdated() {
                            completion(true)
                        } else if iTotalCallComplete == iTotalMultilevelChannelVideos {
                            completion(false)
                        }
                    }, completionError: { (error) in
                        // Error
                        iTotalCallComplete += 1
                        if iTotalCallComplete == iTotalMultilevelChannelVideos {
                            completion(false)
                        }
                    })
                }
            }
        }
    }
}














