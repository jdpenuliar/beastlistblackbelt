//
//  CustomCell.swift
//  blackbeltreview
//
//  Created by JD Penuliar on 7/23/16.
//  Copyright © 2016 JD Penuliar. All rights reserved.
//

import UIKit
import CoreData
class CustomCell: UITableViewCell {
    var customCellIndexPath: IndexPath?
    var customCellText: String?
    var beastButtonDelegate: BeastedButtonDelegate?
    
    
    @IBAction func beastButtonPressed(_ sender: UIButton) {
        beastButtonDelegate?.beastedButtonPressedFrom(self, didFinishMovingBeast: customCellText!, atIndexPath: customCellIndexPath!)
    }
}
