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
    @IBOutlet weak var titleLbl: UILabel?
    @IBOutlet weak var seriesTitleLbl: UILabel?
    @IBOutlet weak var discriptionWidthConstraint: NSLayoutConstraint?
    
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
        self.titleLbl?.text = self.videoObject?.strTitle
        self.seriesTitleLbl?.text = self.videoObject?.strSeriesTitle
    }

}
