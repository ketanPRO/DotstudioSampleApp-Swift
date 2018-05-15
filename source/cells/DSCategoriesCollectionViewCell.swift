//
//  DSCategoriesCollectionViewCell.swift
//  DotstudioSampleApp-iOS
//
//  Created by Anwer on 5/15/18.
//  Copyright © 2018 Dotstudioz. All rights reserved.
//

import UIKit
import DotstudioUI

class DSCategoriesCollectionViewCell: SPLTCategoriesCollectionViewCell {
    @IBOutlet open override var imageViewCell: SPLTBaseImageView? {
        get {
            return super.imageViewCell
        }
        set {
            super.imageViewCell = newValue
        }
    }
    @IBOutlet weak open override var labelPrimaryTitle: UILabel? {
        get {
            return super.labelPrimaryTitle
        }
        set {
            super.labelPrimaryTitle = newValue
        }
    }
    
    override open func prepareForReuse() {
        super.prepareForReuse()
        self.category = nil
        self.imageViewCell?.image = nil
        self.labelPrimaryTitle?.text = ""
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
