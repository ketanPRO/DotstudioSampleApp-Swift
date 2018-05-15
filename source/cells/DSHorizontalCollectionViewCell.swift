//
//  DSHorizontalBaseCollectionViewCell.swift
//  DotstudioSampleApp-iOS
//
//  Created by Anwer on 5/14/18.
//  Copyright © 2018 Dotstudioz. All rights reserved.
//

import UIKit
import DotstudioAPI
import DotstudioUI
import Haneke

open class DSHorizontalCollectionViewCell: SPLTHorizontalBaseCollectionViewCell  {
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
    @IBOutlet weak open override var labelSecondaryTitle: UILabel? {
        get {
            return super.labelSecondaryTitle
        }
        set {
            super.labelSecondaryTitle = newValue
        }
    }
    
    open override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
