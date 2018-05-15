//
//  DSCategoriesCollectionViewCell.swift
//  DotstudioSampleApp-iOS
//
//  Created by Anwer on 5/15/18.
//  Copyright © 2018 Dotstudioz. All rights reserved.
//

import UIKit

open class DSCategoriesCollectionViewCell: SPLTCategoriesTableViewCell {
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
    open override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
