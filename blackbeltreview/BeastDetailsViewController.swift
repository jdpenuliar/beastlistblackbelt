//
//  BeastDetailsViewController.swift
//  blackbeltreview
//
//  Created by JD Penuliar on 7/23/16.
//  Copyright © 2016 JD Penuliar. All rights reserved.
//

import UIKit

class BeastDetailsViewController: UITableViewController{
    var cancelButtonDelegate: CancelButtonDelegate?
    var doneButtonDelegate: DoneButtonDelegate?
    var addBeastStatus = false
    var beastToEditIndexPath: Int?
    var beastToEdit: String?
    
    @IBOutlet weak var beastEditor: UITextField!
    override func viewDidLoad() {
        if self.addBeastStatus == false{
            if let beastFiller = beastToEdit{
                beastEditor.text = beastFiller
                print (beastToEditIndexPath)
            }
        }
        super.viewDidLoad()
    }
    
    @IBAction func doneButtonPressed(_ sender: UIBarButtonItem) {
        if self.addBeastStatus == true{
            doneButtonDelegate?.doneButtonPressedFrom(self, didFinishAddingBeast: beastEditor.text!)
        }else if self.addBeastStatus == false{
            doneButtonDelegate?.doneButtonPressedFrom(self, didFinishAddingBeast: beastEditor.text!, atIndexPath: beastToEditIndexPath!)
        }
    }
    @IBAction func cancelButtonPressed(_ sender: UIBarButtonItem) {
        cancelButtonDelegate?.cancelButtonPressedFrom(self)
    }
}
