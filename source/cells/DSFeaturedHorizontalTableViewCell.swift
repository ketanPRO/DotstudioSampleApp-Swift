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
    @IBOutlet weak open override var collectionView: UICollectionView? {
        get {
            return super.collectionView
        }
        set {
            super.collectionView = newValue
        }
    }
    @IBOutlet weak open var infiniteCarousel: InfiniteCarousel?
    open override func awakeFromNib() {
        super.awakeFromNib()
        self.collectionView?.register(UINib(nibName: "DSFeaturedHorizontalCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "DSFeaturedHorizontalCollectionViewCell")
    }
}

///MARK: -
//MARK: - extension UICollectionViewDataSource
extension DSFeaturedHorizontalTableViewCell {
}



