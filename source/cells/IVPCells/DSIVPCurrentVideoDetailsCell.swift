//
//  DSIVPCurrentVideoDetailsCell.swift
//  DotstudioSampleApp-iOS
//
//  Created by Anwer on 5/17/18.
//  Copyright © 2018 Dotstudioz. All rights reserved.
//

import UIKit
import DotstudioAPI

open class DSIVPCurrentVideoDetailsCell: UICollectionViewCell {
    @IBOutlet weak var labelTitle: UILabel?
    @IBOutlet weak var labelSeriesTitle: UILabel?
    @IBOutlet weak var labelInfo: UILabel?
    @IBOutlet weak var labelDescription: UILabel?
    @IBOutlet weak var constraintDiscriptionWidth: NSLayoutConstraint?
  
    var isExpanded:Bool = false
    var video:SPLTVideo?
    
    override open func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    open func setCellData(_ video: SPLTVideo, isExpanded:Bool = false) {
        self.isExpanded = isExpanded
        self.video = video
        self.updateUI()
    }
    
    open func updateUI() {
        if let video = self.video {
            self.labelTitle?.text = video.strTitle
            self.labelSeriesTitle?.text = video.strSeriesTitle
            self.labelInfo?.text = video.strVideoInfo
            self.labelDescription?.text = video.strDescription
            
            if self.isExpanded == true {
                self.labelDescription?.numberOfLines = 0
            } else {
                self.labelDescription?.numberOfLines = 1
            }
        }
    }

}
