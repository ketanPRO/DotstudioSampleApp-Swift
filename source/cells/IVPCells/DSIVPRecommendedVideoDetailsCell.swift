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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    open func setCellData(_ videoObject: SPLTVideo) {
        self.titleLbl?.text = videoObject.strTitle
        self.seriesTitleLbl?.text = videoObject.strSeriesTitle
    }

}
