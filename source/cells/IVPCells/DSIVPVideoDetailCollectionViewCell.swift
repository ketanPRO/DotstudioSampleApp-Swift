//
//  DSIVPVideoDetailTableViewCell.swift
//  DotstudioSampleApp-iOS
//
//  Created by Anwer on 5/17/18.
//  Copyright © 2018 Dotstudioz. All rights reserved.
//

import UIKit
import DotstudioPRO

import UIKit
 
import DotstudioPRO

public protocol DSIVPVideoDetailCollectionViewCellDelegate {
    func didClickExpandButton(_ dsIVPVideoDetailTableViewCell :DSIVPVideoDetailCollectionViewCell)
}

open class DSIVPVideoDetailCollectionViewCell: SPLTIVPVideoDetailCollectionViewCell {
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
    @IBOutlet open weak override var baseVideoProgressView: SPLTBaseVideoProgressView? {
        get {
            return super.baseVideoProgressView
        }
        set {
            super.baseVideoProgressView = newValue
        }
    }
    @IBOutlet weak var constraintCellWidth: NSLayoutConstraint?
    open var isCurVideoPlaying: Bool = false

    var videoImageSize: CGSize = CGSize(width: 112.0, height: 63.0)
    @IBOutlet weak var buttonExpand: UIButton?
    var isInitialSetup: Bool = true
    let imageIconDefaultSize = CGSize(width: 44, height: 44)

    var isExpanded: Bool = false
    var delegate: DSIVPVideoDetailCollectionViewCellDelegate?
    
    open override func prepareForReuse() {
        super.prepareForReuse()
        
    }
    override open func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    open func setCellData(_ video: SPLTVideo, isCurVideoPlaying: Bool) {
//        if video.strId == self.video?.strId {
//            // Video is already set & UI, so just update expanded state.
//            self.updateExpandedState()
//        } else {
            // Else setup all data...
        self.isCurVideoPlaying = isCurVideoPlaying
            self.video = video
            self.setupButtonIcons()
            super.setCellData(video)
            self.isInitialSetup = false
//        }
    }
    
    open func setupButtonIcons() {
        if self.isInitialSetup {
            let imageExpand = UIImage(icon: .FAEllipsisV, size: self.imageIconDefaultSize, textColor: .white, backgroundColor: .clear)
            self.buttonExpand?.setImage(imageExpand, for: .normal)
        }
    }
    
    open override func updateUI() {
        super.updateUI()
        
        if let strTitle = self.video?.strTitle, strTitle == "" {
            if let iEpisodeNo = self.video?.iEpisodeNo {
                self.labelTitle?.text = "Episode \(iEpisodeNo)"
            }
        }
        
        if self.video != nil {
            self.labelInfo?.text = "" //video.getVideoInfo()
        }
        self.updateExpandedState()
        self.updateTheme()
    }
    
    func updateExpandedState() {
        if let video = self.video {
            self.isExpanded = video.isExpandedUI
            if video.isExpandedUI {
                self.labelDescription?.numberOfLines = 0
            } else {
                self.labelDescription?.numberOfLines = 3
            }
            
            if let strDescription = video.strDescription {
                self.labelDescription?.text = strDescription
            }
        }
    }
    
    func updateTheme() {
        if self.isCurVideoPlaying {
            self.labelTitle?.textColor = UIColor(hex6: 0xFFFFFF)
            self.buttonExpand?.tintColor = UIColor(hex6: 0xFF0101)
        } else {
            self.labelTitle?.textColor = UIColor.white
            self.buttonExpand?.tintColor = UIColor.white
        }
    }
    
    @IBAction func didClickExpandButton(sender: UIButton) {
        self.delegate?.didClickExpandButton(self)
    }
}
