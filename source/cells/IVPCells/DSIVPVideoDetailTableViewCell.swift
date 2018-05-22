//
//  DSIVPVideoDetailTableViewCell.swift
//  DotstudioSampleApp-iOS
//
//  Created by Anwer on 5/17/18.
//  Copyright © 2018 Dotstudioz. All rights reserved.
//

import UIKit
import DotstudioAPI
import DotstudioUI

public protocol DSIVPVideoDetailTableViewCellDelegate {
    func didClickExpandButton(_ dsIVPVideoDetailTableViewCell :DSIVPVideoDetailTableViewCell)
}

open class DSIVPVideoDetailTableViewCell: SPLTIVPVideoDetailTableViewCell {
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
    
    @IBOutlet weak var buttonExpand: UIButton?
    @IBOutlet weak var constraintCellWidth: NSLayoutConstraint?

    var isExpanded: Bool = false
    var delegate: DSIVPVideoDetailTableViewCellDelegate?
    
    override open func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    open override func setCellData(_ video: SPLTVideo) {
        self.video = video
        super.setCellData(video)
    }
    
    open override func updateUI() {
        super.updateUI()
        if let video = self.video {
            self.isExpanded = video.isExpandedUI
            if video.isExpandedUI {
                self.labelDescription?.numberOfLines = 0
            } else {
                self.labelDescription?.numberOfLines = 2
            }
        }
    }
    
    @IBAction func didClickExpandButton(sender: UIButton) {
        self.delegate?.didClickExpandButton(self)
    }
    
    
    

}
