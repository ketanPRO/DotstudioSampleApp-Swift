//
//  SPLTVideoChannel.swift
//  DotstudioPRO
//
//  Created by Ketan Sakariya on 04/01/17.
//  Copyright © 2017 ___DotStudioz___. All rights reserved.
//

import Foundation

open class SPLTVideoChannel: SPLTChannel {
    
    override var channelDict: [String: AnyObject] {
        didSet {
        }
    }
    var video: SPLTVideo?
    var videoDict: [String: AnyObject] = [:] {
        didSet {
            let spltVideo = SPLTVideo(videoDict: videoDict)
            self.video = spltVideo
        }
    }
    var playlistVideos: [SPLTVideo] = []
    var playlist_id: String?
    
    override func mapFromChannelDict(_ channelDict: [String: AnyObject]) {
        super.mapFromChannelDict(channelDict)
        if let videoDict = channelDict["video"] as? [String: AnyObject] {
            self.videoDict = videoDict
        }
    }

    override func isChannelVideosUpdated() -> Bool {
        return self.isVideoChannelUpdated()
    }
    override func loadChannelVideos(_ completion: @escaping (_ bSuccess: Bool) -> Void, completionError: @escaping (_ error: NSError) -> Void) {
        self.loadChannelVideo(completion, completionError: completionError)
    }

    override func getVideoProgressForChannelVideos(_ completion: @escaping (_ responseDictArray: [[String: AnyObject]]) -> Void, completionError: @escaping (_ error: NSError) -> Void) {
        if let video = self.video {
            let spltVideoProgressAPI = SPLTVideoProgressAPI()
            if let strVideoId = video.strId, SPLTRouter.strClientToken != nil {
                spltVideoProgressAPI.getVideoProgressForVideos([strVideoId], completion: { (responseDict) in
                    // success
                }, completionError: { (error) in
                    // error
                })
            }
        }
    }

}


////MARK: -
////MARK: - SPLTPlaylistChannel Methods
extension SPLTVideoChannel {
    func isVideoChannelUpdated() -> Bool {
        if let video = self.video {
            return video.bVideoUpdated
        }
        return false
    }
    func loadChannelVideo(_ completion: @escaping (_ bSuccess: Bool) -> Void, completionError: (_ error: NSError) -> Void) {
        if let video = self.video {
            video.loadPlaylistVideo({ (videoDict) in
                // success
                completion(true)
            }, completionError: { (error) in
                // Error
            })
        }
    }
}





