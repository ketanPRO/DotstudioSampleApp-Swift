//
//  DSIVPVideosSectionHeaderView.swift
//  DotstudioSampleApp-iOS
//
//  Created by Anwer on 5/17/18.
//  Copyright © 2018 Dotstudioz. All rights reserved.
//

import UIKit

class DSIVPVideosSectionHeaderView: UICollectionReusableView {
   @IBOutlet weak var collectionView: UICollectionView?
    override func awakeFromNib() {
        super.awakeFromNib()
        self.collectionView?.register(UINib(nibName: "DSIVPVideosSectionHeaderCell", bundle: nil), forCellWithReuseIdentifier: "DSIVPVideosSectionHeaderCell")
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
}

extension DSIVPVideosSectionHeaderView : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 15
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let categoryCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "DSIVPVideosSectionHeaderCell", for: indexPath) as? DSIVPVideosSectionHeaderCell {
            return categoryCollectionViewCell
        }
        return UICollectionViewCell()
    }
}
