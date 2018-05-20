//
//  DSIVPRecommendedVideoDetailsCell.swift
//  DotstudioSampleApp-iOS
//
//  Created by Anwer on 5/17/18.
//  Copyright © 2018 Dotstudioz. All rights reserved.
//

import UIKit
import DotstudioAPI

class DSIVPRecommendedVideoDetailsCell: UICollectionViewCell {
    @IBOutlet weak var labelTitle: UILabel?
    @IBOutlet weak var labelSeriesTitle: UILabel?
    @IBOutlet weak var constraintDiscriptionWidth: NSLayoutConstraint?
    
    var videoObject:SPLTVideo?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    open func setCellData(_ videoObject: SPLTVideo) {
        self.videoObject = videoObject
        self.updateUI()
    }
    
    open func updateUI() {
        self.labelTitle?.text = self.videoObject?.strTitle
        self.labelSeriesTitle?.text = self.videoObject?.strSeriesTitle
    }

}
