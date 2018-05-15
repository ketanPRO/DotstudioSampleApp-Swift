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
    
    open override func setDspVideo(dspVideo: SPLTVideo) {
        self.dspVideo = dspVideo
        if let strThumbUrl = dspVideo.thumb {
            //            self.imageViewCell?.image = UIImage(contentsOfFile: strThumbUrl)
            //            if let url = URL(string: strThumbUrl) {
            //                self.imageViewCell?.hnk_setImageFromURL(url)
            //            }
            self.imageViewCell?.splt_setImageFromStrImagePath(strThumbUrl)
        }
        if let strTitle = dspVideo.strTitle {
            self.labelPrimaryTitle?.text = strTitle
        }
        self.labelSecondaryTitle?.text = ""
    }

    open override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
