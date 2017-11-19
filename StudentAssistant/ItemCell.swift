//
//  ItemCell.swift
//  StudentAssistant
//
//  Created by Alixa Bahena on 11/19/17.
//  Copyright © 2017 AlixaBahena. All rights reserved.
//

import UIKit

class ItemCell : UITableViewCell {
    
    @IBOutlet var courseNameLabel: UILabel!
    @IBOutlet var courseNumLable: UILabel!
   
    override func awakeFromNib() {
        super.awakeFromNib()
        courseNumLable.adjustsFontForContentSizeCategory = true
        courseNameLabel.adjustsFontForContentSizeCategory = true
       
    }
    
}
