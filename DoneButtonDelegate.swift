//
//  DoneButtonDelegate.swift
//  blackbeltreview
//
//  Created by JD Penuliar on 7/23/16.
//  Copyright © 2016 JD Penuliar. All rights reserved.

import UIKit

protocol DoneButtonDelegate: class {
    func doneButtonPressedFrom(_ controller: UIViewController, didFinishAddingBeast beast: String)
    func doneButtonPressedFrom(_ controller: UIViewController, didFinishAddingBeast beast: String, atIndexPath indexPath: Int)
}
