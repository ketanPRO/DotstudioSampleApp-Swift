//
//  DSIVPVideoDetailsCell.swift
//  DotstudioSampleApp-iOS
//
//  Created by Anwer on 5/17/18.
//  Copyright © 2018 Dotstudioz. All rights reserved.
//

import UIKit
import DotstudioAPI

public protocol DSIVPVideoDetailsCellDelegate {
    func didClickExpandButton(_ dsIVPVideoDetailsCell :DSIVPVideoDetailsCell)
}

open class DSIVPVideoDetailsCell: UICollectionViewCell {
    @IBOutlet weak var labelTitle: UILabel?
    @IBOutlet weak var labelSeriesTitle: UILabel?
    @IBOutlet weak var labelInfo: UILabel?
    @IBOutlet weak var labelDescription: UILabel?
    @IBOutlet weak var constraintDiscriptionWidth: NSLayoutConstraint?
    @IBOutlet weak var buttonExpand: UIButton?
    
    var video:SPLTVideo?
    var isExpanded:Bool = false
    var delegate: DSIVPVideoDetailsCellDelegate?
    
    override open func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    open func setCellData(_ video: SPLTVideo) {
        self.video = video
        self.updateUI()
    }
    
    open func updateUI() {
        if let video = self.video {
            self.isExpanded = video.isExpandedUI
            self.labelTitle?.text = video.strTitle
            self.labelSeriesTitle?.text = video.strSeriesTitle
            self.labelInfo?.text = video.strVideoInfo
            self.labelDescription?.text = video.strDescription
            
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
