//
//  DSIVPCurrentVideoDetailsCell.swift
//  DotstudioSampleApp-iOS
//
//  Created by Anwer on 5/17/18.
//  Copyright © 2018 Dotstudioz. All rights reserved.
//

import UIKit
import DotstudioAPI

class DSIVPCurrentVideoDetailsCell: UICollectionViewCell {
    @IBOutlet weak var titleLbl: UILabel?
    @IBOutlet weak var seriesTitleLbl: UILabel?
    @IBOutlet weak var infoLbl: UILabel?
    @IBOutlet weak var discriptionLbl: UILabel?
    @IBOutlet weak var discriptionWidthConstraint: NSLayoutConstraint?
  
    var isExpanded:Bool = false
    var videoObject:SPLTVideo?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    open func setCellData(_ videoObject: SPLTVideo, isExpanded:Bool = false) {
        self.isExpanded = isExpanded
        self.videoObject = videoObject
        self.updateUI()
    }
    
    open func updateUI() {
        self.titleLbl?.text = self.videoObject?.strTitle
        self.seriesTitleLbl?.text = self.videoObject?.strSeriesTitle
        self.infoLbl?.text = self.videoObject?.strVideoInfo
        self.discriptionLbl?.text = self.videoObject?.strDescription
        
        if self.isExpanded == true {
            discriptionLbl?.numberOfLines = 0
        } else {
            discriptionLbl?.numberOfLines = 1
        }
    }

}
