//
//  CourseCell.swift
//  StudentAssistant
//
//  Created by Jonathan Martin on 11/25/17.
//  Copyright © 2017 AlixaBahena. All rights reserved.
//

import UIKit

class CourseCell : UITableViewCell {
    
    
    @IBOutlet var assignmentLabel: UILabel!
    @IBOutlet var assignmentDueDateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        assignmentLabel.adjustsFontForContentSizeCategory = true
        assignmentDueDateLabel.adjustsFontForContentSizeCategory = true
        
    }
    
}
