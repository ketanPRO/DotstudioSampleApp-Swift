//
//  DSCategoryViewController.swift
//  DotstudioSampleApp
//
//  Created by Anwer on 5/16/18.
//  Copyright © 2018 Dotstudioz. All rights reserved.
//

import UIKit
import DotstudioUI
import DotstudioAPI

class DSCategoryViewController: SPLTCategoryViewController {
    
    @IBOutlet weak override var collectionView: UICollectionView? {
        get {
            return super.collectionView
        }
        set {
            super.collectionView = newValue
        }
    }
    
    @IBInspectable override open var collectionViewItemSize: CGSize {
        get {
            return super.collectionViewItemSize
        }
        set {
            super.collectionViewItemSize = newValue
        }
    }
    
    @IBInspectable override open var collectionViewImageSize: CGSize {
        get {
            return super.collectionViewImageSize
        }
        set {
            super.collectionViewImageSize = newValue
        }
    }
    
    @IBInspectable override open var collectionViewNumberOfColumns: Int {
        get {
            return super.collectionViewNumberOfColumns
        }
        set {
            super.collectionViewNumberOfColumns = newValue
        }
    }
    
    @IBInspectable override open var collectionViewItemSpacing: Int {
        get {
            return super.collectionViewItemSpacing
        }
        set {
            super.collectionViewItemSpacing = newValue
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.collectionView?.register(UINib(nibName: "DSCategoriesCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "DSCategoriesCollectionViewCell")
    }
    
    override func getCollectionViewItemSize() -> CGSize {
        #if os(iOS)
        if UIDevice.current.userInterfaceIdiom == .pad {
            return self.getCollectionViewItemSizeForIpad()
        }
        #endif
        
        var collectionViewItemWidth = self.view.frame.width - (CGFloat(self.collectionViewNumberOfColumns + 1) * CGFloat(self.collectionViewItemSpacing))
        if self.collectionViewNumberOfColumns == 1 {
            collectionViewItemWidth = self.view.frame.width
        }
        collectionViewItemWidth = collectionViewItemWidth / CGFloat(self.collectionViewNumberOfColumns)
        let collectionViewItemHeight = collectionViewItemWidth*9/16
        let size = CGSize(width: collectionViewItemWidth, height: collectionViewItemHeight)
        return size
    }
    
    override func resetCollectionViewSize(_ collectionViewItemSize: CGSize) {
        super.resetCollectionViewSize(collectionViewItemSize)
        
        if let flowLayout = self.collectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.minimumLineSpacing = CGFloat(self.collectionViewItemSpacing)
            flowLayout.minimumInteritemSpacing = CGFloat(self.collectionViewItemSpacing)
            flowLayout.sectionInset = UIEdgeInsetsMake(CGFloat(self.collectionViewItemSpacing), 0, CGFloat(self.collectionViewItemSpacing), 0)
        }
    }
}

extension DSCategoryViewController {
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let categoryCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "DSCategoriesCollectionViewCell", for: indexPath) as? DSCategoriesCollectionViewCell {
            let channel = self.category!.channels[indexPath.row]
            let collectionViewImageSize = self.getCollectionViewImageSize()
            categoryCollectionViewCell.cellType = DSCategoriesCollectionViewCell.cellTypes.Channel.rawValue
            categoryCollectionViewCell.setCellChannelData(channel, collectionViewImageSize: collectionViewImageSize)
            return categoryCollectionViewCell
        }
        return UICollectionViewCell()
    }
}