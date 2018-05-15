//
//  DSFeaturedHorizontalTableViewCell.swift
//  DotstudioSampleApp-iOS
//
//  Created by Ketan Sakariya on 11/05/18.
//  Copyright © 2018 Dotstudioz. All rights reserved.
//

import Foundation
import UIKit
import DotstudioAPI
import DotstudioUI
import Haneke

open class DSFeaturedHorizontalTableViewCell: DSHorizontalTableViewCell  {
    
    open override func awakeFromNib() {
        super.awakeFromNib()
        self.collectionView?.register(UINib(nibName: "DSFeaturedHorizontalCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "DSFeaturedHorizontalCollectionViewCell")
    }
}





