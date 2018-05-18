//
//  DSIVPVideoDetailsCell.swift
//  DotstudioSampleApp-iOS
//
//  Created by Anwer on 5/17/18.
//  Copyright © 2018 Dotstudioz. All rights reserved.
//

import UIKit
import DotstudioAPI

class DSIVPVideoDetailsCell: UICollectionViewCell {
    @IBOutlet weak var titleLbl: UILabel?
    @IBOutlet weak var seriesTitleLbl: UILabel?
    @IBOutlet weak var infoLbl: UILabel?
    @IBOutlet weak var discriptionLbl: UILabel?
    @IBOutlet weak var discriptionWidthConstraint: NSLayoutConstraint?
    @IBOutlet weak var expandableButton: UIButton?
    
    var videoObject:SPLTVideo?
    weak var delegate: MultiSeriesChannelDelegate?
    
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
        self.infoLbl?.text = self.videoObject?.strVideoInfo
        
        if self.expandableButton?.tag == 1 {
            self.discriptionLbl?.text = self.videoObject?.strDescription
            self.discriptionLbl?.numberOfLines = 0
        } else {
            self.discriptionLbl?.text = ""
            self.discriptionLbl?.numberOfLines = 1
        }
    }
    
    @IBAction func expandedButtonAction(sender: UIButton) {
        if sender.tag == 0 {
            self.discriptionLbl?.text = self.videoObject?.strDescription
            sender.tag = 1
            self.discriptionLbl?.numberOfLines = 0
        } else {
            self.discriptionLbl?.text = ""
            sender.tag = 0
            self.discriptionLbl?.numberOfLines = 1
        }
        delegate?.reloadCollectionViewData()
    }
    
    
    

}
