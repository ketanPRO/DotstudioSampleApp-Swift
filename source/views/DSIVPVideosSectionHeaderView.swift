//
//  DSIVPVideosSectionHeaderView.swift
//  DotstudioSampleApp-iOS
//
//  Created by Anwer on 5/17/18.
//  Copyright © 2018 Dotstudioz. All rights reserved.
//

import UIKit
import DotstudioAPI

protocol DSIVPVideosSectionHeaderViewDelegate {
    func didClickExpandButtonInHeaderView(_ dsIVPVideosSectionHeaderView :DSIVPVideosSectionHeaderView)
}
class DSIVPVideosSectionHeaderView: UICollectionReusableView {
    
    var delegate: DSIVPVideosSectionHeaderViewDelegate?
   @IBOutlet weak var collectionView: UICollectionView?
    
    @IBOutlet weak var buttonMore: UIButton?
    var spltMultiLevelChannel: SPLTMultiLevelChannel?
    var isExpanded: Bool = true
    var isInitialSetup: Bool = true
    let imageIconDefaultSize = CGSize(width: 22, height: 22)

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
    
    open func setCellData(_ channel: SPLTChannel?) {
        if let spltMultiLevelChannel = channel as? SPLTMultiLevelChannel {
            self.spltMultiLevelChannel = spltMultiLevelChannel
            self.collectionView?.isHidden = false
        } else {
            self.collectionView?.isHidden = true
        }
        self.setupButtonIcons()
//        super.setCellData(video)
        self.isInitialSetup = false
    }
    
    open func setupButtonIcons() {
        if self.isInitialSetup {
            let imageMoreExpanded = UIImage(icon: .FAChevronDown, size: self.imageIconDefaultSize, textColor: .black, backgroundColor: .clear)
            self.buttonMore?.setImage(imageMoreExpanded, for: .normal)
        }
    }
    
    open func updateUI() {
        if self.isExpanded {
            let imageMoreExpanded = UIImage(icon: .FAChevronDown, size: self.imageIconDefaultSize, textColor: .black, backgroundColor: .clear)
            self.buttonMore?.setImage(imageMoreExpanded, for: .normal)
        } else {
            let imageMoreCollapsed = UIImage(icon: .FAChevronUp, size: self.imageIconDefaultSize, textColor: .black, backgroundColor: .clear)
            self.buttonMore?.setImage(imageMoreCollapsed, for: .normal)
        }
    }
    
    @IBAction func didClickExpandButton(sender: UIButton) {
        self.delegate?.didClickExpandButtonInHeaderView(self)
    }
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
