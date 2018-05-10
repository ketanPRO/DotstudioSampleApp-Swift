//
//  DSBrowseViewController.swift
//  DotstudioSampleApp-iOS
//
//  Created by Ketan Sakariya on 09/05/18.
//  Copyright © 2018 Dotstudioz. All rights reserved.
//

import Foundation
import DotstudioUI
import DotstudioAPI
import UIKit

@IBDesignable
open class DSBrowseViewController: SPLTBrowseViewController {
    
    @IBOutlet weak open override var tableView: UITableView? {
        get {
            return super.tableView
        }
        set {
            super.tableView = newValue
        }
    }
    open override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    open override func sequenceAndSetCategories(categories: [SPLTCategory]) {
        super.sequenceAndSetCategories(categories: categories)
    }
    
    open override func numberOfSections(in tableView: UITableView) -> Int {
        let i = super.numberOfSections(in: tableView)
        return i
    }
    
    open override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let dsHorizontalBaseTVC = tableView.dequeueReusableCell(withIdentifier: "DSHorizontalBaseTVC") as? DSHorizontalBaseTVC {
            let category = self.categoriesBrowse[indexPath.section]
            dsHorizontalBaseTVC.setCellData(category)
            return dsHorizontalBaseTVC

        }

        
        
        
        return UITableViewCell() //tableView.dequeueReusableCell(withIdentifier: "cell")!
        
        
        
    }
    
    
}
