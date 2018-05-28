//
//  DSIVPCurrentVideoDetailTableViewCell.swift
//  DotstudioSampleApp-iOS
//
//  Created by Anwer on 5/17/18.
//  Copyright © 2018 Dotstudioz. All rights reserved.
//

import UIKit
import DotstudioAPI
import DotstudioUI

open class DSIVPCurrentVideoDetailTableViewCell: SPLTIVPVideoDetailTableViewCell {
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
  
    var isExpanded:Bool = false
    let imageIconDefaultSize = CGSize(width: 66, height: 66)

    @IBOutlet weak var buttonShare: UIButton!
    @IBOutlet weak var buttonCast: UIButton!
    override open func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        let imageTopBarShare = UIImage(icon: .FAShare, size: self.imageIconDefaultSize, textColor: .white, backgroundColor: .clear)
        self.buttonShare.setImage(imageTopBarShare, for: .normal)

    }
    
//    open func setCellWidth(_ width: CGFloat) {
//        self.constraintCellWidth?.constant = width
//        self.constraintCellWidth?.isActive = true
//    }
    
    open func setCellData(_ video: SPLTVideo, isExpanded:Bool = false) {
//        self.setCellWidth(375.0)
        self.video = video
        self.isExpanded = isExpanded
        self.setCellData(video)
    }
    
    open override func updateUI() {
        super.updateUI()
        if self.isExpanded == true {
            self.labelDescription?.numberOfLines = 0
        } else {
            self.labelDescription?.numberOfLines = 1
        }
    }

}
