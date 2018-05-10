//
//  DSHorizontalBaseTableViewCell.swift
//  DotstudioSampleApp
//
//  Created by Ketan Sakariya on 10/05/18.
//  Copyright © 2018 Dotstudioz. All rights reserved.
//

import Foundation
import UIKit
import DotstudioAPI
import DotstudioUI

open class DSHorizontalBaseCollectionViewCell: SPLTHorizontalBaseCollectionViewCell  {
//    @IBOutlet weak open var imageViewCell: SPLTBaseImageView?
//    @IBOutlet weak open var labelPrimaryTitle: UILabel?
//    @IBOutlet weak open var labelSecondaryTitle: UILabel?
    

    
}


//MARK:-
//MARK:-
//MARK:- TableView Cells
//protocol SPLTHorizontalBaseTVCDelegate {
//    open func spltHorizontalBaseTVC(_ spltHorizontalBaseTVC: SPLTHorizontalBaseTVC, didSelectChannel dspChannel: SPLTChannel, atIndex index: Int)
//    open func spltHorizontalBaseTVC(_ spltHorizontalBaseTVC: SPLTHorizontalBaseTVC, didSelectVideo dspVideo: SPLTVideo, inChannel dspChannel: SPLTChannel?, atIndex index: Int)
//}


open class DSHorizontalBaseTVC: SPLTHorizontalBaseTVC {
//    open var delegate: SPLTHorizontalBaseTVCDelegate?
//    open var dspCategory: SPLTCategory?
    @IBOutlet weak open override var labelTitle: UILabel? {
        get {
            return super.labelTitle
        }
        set {
            super.labelTitle = newValue
        }
    }
    @IBOutlet weak open override var collectionView: UICollectionView? {
        get {
            return super.collectionView
        }
        set {
            super.collectionView = newValue
        }
    }
    

    
}

///MARK: -
//MARK: - extension UICollectionViewDataSource
extension DSHorizontalBaseTVC {

}

//MARK: -
//MARK: - extension UICollectionViewDelegateFlowLayout
extension DSHorizontalBaseTVC {
}




