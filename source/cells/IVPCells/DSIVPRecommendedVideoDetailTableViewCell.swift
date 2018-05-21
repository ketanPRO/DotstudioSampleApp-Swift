//
//  DSIVPRecommendedVideoDetailTableViewCell.swift
//  DotstudioSampleApp-iOS
//
//  Created by Anwer on 5/17/18.
//  Copyright © 2018 Dotstudioz. All rights reserved.
//

import UIKit
import DotstudioAPI
import DotstudioUI

class DSIVPRecommendedVideoDetailTableViewCell: SPLTIVPVideoDetailTableViewCell {

    @IBOutlet open override var imageViewCell: SPLTBaseImageView? {
        get {
            return super.imageViewCell
        }
        set {
            super.imageViewCell = newValue
        }
    }
    @IBOutlet open weak override var labelTitle: UILabel? {
        get {
            return super.labelTitle
        }
        set {
            super.labelTitle = newValue
        }
    }
    @IBOutlet open weak override var labelSeriesTitle: UILabel? {
        get {
            return super.labelSeriesTitle
        }
        set {
            super.labelSeriesTitle = newValue
        }
    }
    @IBOutlet open weak override var labelInfo: UILabel? {
        get {
            return super.labelInfo
        }
        set {
            super.labelInfo = newValue
        }
    }
    @IBOutlet open weak override var labelDescription: UILabel? {
        get {
            return super.labelDescription
        }
        set {
            super.labelDescription = newValue
        }
    }
    @IBOutlet weak var constraintCellWidth: NSLayoutConstraint?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    open override func setCellData(_ video: SPLTVideo) {
        self.video = video
        super.setCellData(video)
    }
    
    open override func updateUI() {
        super.updateUI()
    }

}
