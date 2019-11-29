//
//  DSFeaturedHorizontalBaseCollectionViewCell.swift
//  DotstudioSampleApp
//
//  Created by Ketan Sakariya on 15/05/18.
//  Copyright © 2018 Dotstudioz. All rights reserved.
//

import Foundation
import UIKit
import DotstudioPRO

protocol DSFeaturedHorizontalCollectionViewCellDelegate {
    func didClickWatchNowButton(_ dsFeaturedHorizontalCollectionViewCell: DSFeaturedHorizontalCollectionViewCell)
    func didAddedChannelToWatchList(_ dsFeaturedHorizontalCollectionViewCell: DSFeaturedHorizontalCollectionViewCell, channel:SPLTChannel)
    func didFaildToAddChannelToWatchList(_ dsFeaturedHorizontalCollectionViewCell: DSFeaturedHorizontalCollectionViewCell, channel:SPLTChannel)
}

open class DSFeaturedHorizontalCollectionViewCell: DSHorizontalCollectionViewCell  {

    var delegate: DSFeaturedHorizontalCollectionViewCellDelegate?
    @IBOutlet weak var imageViewChannelLogo: SPLTBaseImageView?
    @IBOutlet weak var buttonAddToMylist: UIButton?
    @IBOutlet weak var buttonWatchNow: UIButton?

    open override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    open override func prepareForReuse() {
        super.prepareForReuse()
//        self.buttonAddToMylist?.isHidden = true
        self.imageViewChannelLogo?.image = nil
    }

    open override func setChannel(channel: SPLTChannel, collectionViewImageSize: CGSize) {
//        self.imageKey = "poster"
        super.setChannel(channel: channel, collectionViewImageSize: collectionViewImageSize)
        self.buttonAddToMylist?.titleLabel?.text = "Add To My List"
        if let strChannelLogoPath = channel.channel_logo {
            if let imageViewChannelLogo = self.imageViewChannelLogo {
                imageViewChannelLogo.splt_setImageFromStrImagePath(strChannelLogoPath, width: 0, height: Int(imageViewChannelLogo.frame.height))
            }
        }
         #if os(tvOS)
            self.labelPrimaryTitle?.text = channel.strDescription

            self.buttonWatchNow?.isHidden = true
            self.checkSubscriptionStatusAndUpdateButtonTitle()
         #endif
    }

    open func getParentChannelId(_ channel: SPLTChannel) ->  String? {
        var strParentChannelId:String?
        if let _ = channel as? SPLTMultiLevelChannel {
            if let strChannelId = channel.strId {
                strParentChannelId = strChannelId
            }
        } else {
            strParentChannelId = nil
        }
        return strParentChannelId
    }


    func addChannelToMyList(_ strChannelId: String) {
        var strParentChannelId:String?
        if let channel = self.channel {
            strParentChannelId = self.getParentChannelId(channel)
        }

        SPLTWatchlistAPI().addChannelToWatchlist(strChannelId, strParentChannelId:strParentChannelId , completion: { (responseDict) in
            if let channel = self.channel {
                self.delegate?.didAddedChannelToWatchList(self, channel: channel)
            }
        }) { (error) in
            // error
            if let channel = self.channel {
                self.delegate?.didFaildToAddChannelToWatchList(self, channel: channel)
            }
        }
    }
    //MARK: - IBAction methods
    @IBAction func didClickWatchNowButton(sender: UIButton) {
        self.delegate?.didClickWatchNowButton(self)
    }
    @IBAction func didClickAddToMylistButton(_ sender: Any) {

        if (SPLTUser.sharedInstance.isLoggedinUser()){
            if let multilevelChannel = self.channel as? SPLTMultiLevelChannel {
                if let firstChildChannel = multilevelChannel.childChannels.first {
                    if let strChannelId = firstChildChannel.strId {
                        self.addChannelToMyList(strChannelId)
                    }
                }
            } else {
                if let strChannelId = self.channel?.strId {
                    self.addChannelToMyList(strChannelId)
                }
            }
        } else {
            //Show alert
            //_ = DSUtility.shared.showAlertOnWindow("Pivot", message: "Please login to add item to my list.", preferredStyle: .alert)

        }
    }

    #if os(tvOS)
    func checkSubscriptionStatusAndUpdateButtonTitle() {
        if let channel = self.channel {
            SPLTSubscriptionUtility.shared.checkSubscriptionStatus(channel, completion: { (bSubscriptionUnlocked, bAdsEnabled) in
                self.buttonWatchNow?.isHidden = false
                if !bSubscriptionUnlocked {
                    self.buttonWatchNow?.setTitle("Subscribe Now", for: UIControl.State.normal)
                } else {
                    self.buttonWatchNow?.setTitle("Watch Now", for: UIControl.State.normal)
                }
            }) { (error) in
                self.buttonWatchNow?.isHidden = false
                self.buttonWatchNow?.setTitle("Watch Now", for: UIControl.State.normal)
            }
        }
    }


    override open func didUpdateFocus(in context: UIFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        super.didUpdateFocus(in: context, with: coordinator)
        if self.isFocused {
            self.buttonWatchNow?.backgroundColor = UIColor(red: 17/255, green: 221/255, blue: 245/255, alpha: 1.0)
            self.buttonWatchNow?.titleLabel?.textColor = UIColor.black
        } else {
            self.buttonWatchNow?.backgroundColor = UIColor.white
            self.buttonWatchNow?.titleLabel?.textColor = UIColor.black
        }
    }
    #endif
}

