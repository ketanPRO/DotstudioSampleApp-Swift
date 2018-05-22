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
    @IBOutlet weak open var buttonWatchNow: UIButton?
    
    open override func awakeFromNib() {
        super.awakeFromNib()
        self.collectionView?.register(UINib(nibName: "DSFeaturedHorizontalCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "DSFeaturedHorizontalCollectionViewCell")
    }
    
    #if os(tvOS)
//    override open func didUpdateFocus(in context: UIFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
//        super.didUpdateFocus(in: context, with: coordinator)
//        if self.isFocused {
//            self.buttonWatchNow?.setTitleColor(.white, for: .normal)
//            self.buttonWatchNow?.setTitleColor(.white, for: .focused)
//            self.buttonWatchNow?.backgroundColor = UIColor(hexString: "#ED1D1D") //.red
//        } else {
//            self.buttonWatchNow?.setTitleColor(.white, for: .normal)
//            self.buttonWatchNow?.setTitleColor(.white, for: .focused)
//            self.buttonWatchNow?.backgroundColor = UIColor(hexString: "#1E1F1F") //.black
//        }
//    }
    #endif
}

///MARK: -
//MARK: - extension UICollectionViewDataSource
extension DSFeaturedHorizontalTableViewCell {
}



