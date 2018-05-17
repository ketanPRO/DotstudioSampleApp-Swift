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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    open func setCellData(_ videoObject: SPLTVideo) {
        self.titleLbl?.text = videoObject.strTitle
        self.seriesTitleLbl?.text = videoObject.strSeriesTitle
        self.infoLbl?.text = videoObject.strVideoInfo
        self.discriptionLbl?.text = videoObject.strDescription
    }
    

}
