//
//  BeastedButtonDelegate.swift
//  blackbeltreview
//
//  Created by JD Penuliar on 7/24/16.
//  Copyright © 2016 JD Penuliar. All rights reserved.
//

import UIKit
protocol BeastedButtonDelegate: class{
    
    func beastedButtonPressedFrom(_ customCell: CustomCell, didFinishMovingBeast beasted: String, atIndexPath indexPath: IndexPath)
}
