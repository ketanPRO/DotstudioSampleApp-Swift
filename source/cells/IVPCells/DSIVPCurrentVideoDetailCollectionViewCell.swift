//
//  DSIVPCurrentVideoDetailTableViewCell.swift
//  DotstudioSampleApp-iOS
//
//  Created by Anwer on 5/17/18.
//  Copyright © 2018 Dotstudioz. All rights reserved.
//

import UIKit
import DotstudioPRO

public protocol DSIVPCurrentVideoDetailCollectionViewCellDelegate {
    func didClickShareButton(_ dsIVPCurrentVideoDetailCollectionViewCell :DSIVPCurrentVideoDetailCollectionViewCell, sender: UIButton)
    func didClickCastButton(_ dsIVPCurrentVideoDetailCollectionViewCell :DSIVPCurrentVideoDetailCollectionViewCell, sender: UIButton)
}

open class DSIVPCurrentVideoDetailCollectionViewCell: SPLTIVPVideoDetailCollectionViewCell {
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
    
    var delegate: DSIVPCurrentVideoDetailCollectionViewCellDelegate?
    @IBOutlet weak var constraintCellWidth: NSLayoutConstraint?
  
    var isExpanded:Bool = false
    var isInitialSetup: Bool = true
    let imageIconDefaultSize = CGSize(width: 66, height: 66)

    @IBOutlet weak var buttonShare: UIButton?
    @IBOutlet weak var buttonCast: UIButton?
    override open func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

    }
    
//    open func setCellWidth(_ width: CGFloat) {
//        self.constraintCellWidth?.constant = width
//        self.constraintCellWidth?.isActive = true
//    }
    
    
    open func setCellData(_ video: SPLTVideo, isExpanded:Bool = false) {
//        self.setCellWidth(375.0)
        self.video = video
        self.setupButtonIcons()
        self.isExpanded = isExpanded
        self.setCellData(video)
        self.isInitialSetup = false
    }
    open func setupButtonIcons() {
        if self.isInitialSetup {
            let imageTopBarShare = UIImage(icon: .FAShare, size: self.imageIconDefaultSize, textColor: .black, backgroundColor: .clear)
            self.buttonShare?.setImage(imageTopBarShare, for: .normal)
        }
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
