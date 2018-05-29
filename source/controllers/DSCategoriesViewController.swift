//
//  DSCategoriesViewController.swift
//  DotstudioSampleApp-iOS
//
//  Created by Anwer on 5/15/18.
//  Copyright © 2018 Dotstudioz. All rights reserved.
//

import UIKit
import DotstudioUI
import DotstudioAPI

class DSCategoriesViewController: SPLTCategoriesViewController {
    
    @IBOutlet weak override var collectionView: UICollectionView? {
        get {
            return super.collectionView
        }
        set {
            super.collectionView = newValue
        }
    }
    
//    @IBInspectable override open var collectionViewItemSize: CGSize {
//        get {
//            return super.collectionViewItemSize
//        }
//        set {
//            super.collectionViewItemSize = newValue
//        }
//    }
//
//    @IBInspectable override open var collectionViewImageSize: CGSize {
//        get {
//            return super.collectionViewImageSize
//        }
//        set {
//            super.collectionViewImageSize = newValue
//        }
//    }
    
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
    @IBInspectable override open var filterCriteria: String {
        get {
            return super.filterCriteria
        }
        set {
            super.filterCriteria = newValue
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.collectionView?.register(UINib(nibName: "DSGenericCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "DSGenericCollectionViewCell")
        
        
        var collectionViewItemWidth = self.view.frame.width - (CGFloat(self.collectionViewNumberOfColumns + 1) * CGFloat(self.collectionViewItemSpacing))
        if self.collectionViewNumberOfColumns == 1 {
            collectionViewItemWidth = self.view.frame.width
        }
        collectionViewItemWidth = collectionViewItemWidth / CGFloat(self.collectionViewNumberOfColumns)
        let collectionViewItemHeight = collectionViewItemWidth
        let size = CGSize(width: collectionViewItemWidth, height: collectionViewItemHeight)
        self.resetCollectionViewSize(size)
    }
    
    open func resetCollectionViewSize(_ collectionViewItemSize: CGSize) {
        if let flowLayout = self.collectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.itemSize = collectionViewItemSize
        }
        
    }

//    override func getCollectionViewItemSize() -> CGSize {
////        #if os(iOS)
////        if UIDevice.current.userInterfaceIdiom == .pad {
////            return self.getCollectionViewItemSizeForIpad()
////        }
////        #endif
//        
//        var collectionViewItemWidth = self.view.frame.width - (CGFloat(self.collectionViewNumberOfColumns + 1) * CGFloat(self.collectionViewItemSpacing))
//        if self.collectionViewNumberOfColumns == 1 {
//            collectionViewItemWidth = self.view.frame.width
//        }
//        collectionViewItemWidth = collectionViewItemWidth / CGFloat(self.collectionViewNumberOfColumns)
//        let collectionViewItemHeight = collectionViewItemWidth
//        let size = CGSize(width: collectionViewItemWidth, height: collectionViewItemHeight)
//        return size
//    }

    
}

extension DSCategoriesViewController {
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let categoryCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "DSGenericCollectionViewCell", for: indexPath) as? DSGenericCollectionViewCell {
                let category = self.categories[indexPath.row]
//                let collectionViewImageSize = self.getCollectionViewImageSize()
                categoryCollectionViewCell.setCellData(category, collectionViewImageSize: self.collectionViewImageSize)
            return categoryCollectionViewCell
        }
        return UICollectionViewCell()
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let categoryViewController: DSCategoryViewController? = UIStoryboard(name: "category", bundle: nil).instantiateViewController(withIdentifier: "DSCategoryViewController") as? DSCategoryViewController
        categoryViewController?.category =  self.categories[indexPath.row]
        navigationController?.pushViewController(categoryViewController!, animated: true)
    }
}
