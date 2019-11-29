//
//  DSIVPRecommendedVideoDetailTableViewCell.swift
//  DotstudioSampleApp-iOS
//
//  Created by Anwer on 5/17/18.
//  Copyright © 2018 Dotstudioz. All rights reserved.
//

import UIKit
import DotstudioPRO

class DSIVPRecommendedVideoDetailCollectionViewCell: SPLTGenericCollectionViewCell {

    @IBOutlet open override var imageViewCell: SPLTBaseImageView? {
        get {
            return super.imageViewCell
        }
        set {
            super.imageViewCell = newValue
        }
    }
    
    override func updateChannelUI(){
        if let channel = self.channel {
            if let strTitle = channel.strTitle {
                self.labelPrimaryTitle?.text = strTitle
            }
            if let strImageUrl = channel.spotlight_poster {
                let strFinalImagePath = SPLTFullPathRouter.imagePath(strImageUrl, Int(collectionViewImageSize.width), Int(collectionViewImageSize.height)).URLString
                //self.imageViewCell?.kf.setImage(with: URL(string:strFinalImagePath))
            }
        }
    }
}
