//
//  DSHorizontalBaseCollectionViewCell.swift
//  DotstudioSampleApp-iOS
//
//  Created by Anwer on 5/14/18.
//  Copyright © 2018 Dotstudioz. All rights reserved.
//

import UIKit
import DotstudioAPI
import DotstudioUI
import Haneke

open class DSHorizontalCollectionViewCell: SPLTHorizontalBaseCollectionViewCell  {
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
    
    open override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
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
