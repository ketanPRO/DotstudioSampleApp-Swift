//
//  DSHorizontalCategoryChannelVideoCollectionViewCell.swift
//  DotstudioSampleApp-iOS
//
//  Created by Ketan Sakariya on 30/05/18.
//  Copyright © 2018 Dotstudioz. All rights reserved.
//

import UIKit
import DotstudioPRO

class DSHorizontalCategoryChannelVideoCollectionViewCell: SPLTHorizontalBaseCollectionViewCell {

    @IBOutlet open override var imageViewCell: SPLTBaseImageView? {
        get {
            return super.imageViewCell
        }
        set {
            super.imageViewCell = newValue
        }
    }
    @IBOutlet weak open override var labelPrimaryTitle: UILabel? {
        get {
            return super.labelPrimaryTitle
        }
        set {
            super.labelPrimaryTitle = newValue
        }
    }
    @IBOutlet weak open override var labelSecondaryTitle: UILabel? {
        get {
            return super.labelSecondaryTitle
        }
        set {
            super.labelSecondaryTitle = newValue
        }
    }
    @IBOutlet weak open override var baseVideoProgressView: SPLTBaseVideoProgressView? {
        get {
            return super.baseVideoProgressView
        }
        set {
            super.baseVideoProgressView = newValue
        }
    }
    
    open override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.labelPrimaryTitle?.textColor = UIColor.white
        self.labelSecondaryTitle?.textColor = UIColor.white
    }
    
    open override func setChannel(channel: SPLTChannel, collectionViewImageSize: CGSize) {
        self.channel = channel
        self.collectionViewImageSize = collectionViewImageSize
        //        var strImageUrl = "" //"https://f9q4g5j6.ssl.hwcdn.net/5a5816cd97f8156c1988d889"
        
        if self.imageKey == "poster", let strImageUrl = channel.poster {
            self.imageViewCell?.splt_setImageFromStrImagePath(strImageUrl, sizeImage: collectionViewImageSize)
        } else if self.imageKey == "spotlight_poster", let strImageUrl = channel.spotlight_poster {
            self.imageViewCell?.splt_setImageFromStrImagePath(strImageUrl, sizeImage: collectionViewImageSize)
        } else if let strPosterUrl = channel.poster {
            self.imageViewCell?.splt_setImageFromStrImagePath(strPosterUrl, sizeImage: collectionViewImageSize)
        }
        
        if let strTitle = channel.strTitle {
            self.labelPrimaryTitle?.text = strTitle
        }
        self.labelSecondaryTitle?.text = ""
    }
}
