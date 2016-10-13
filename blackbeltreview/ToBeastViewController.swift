//
//  ToBeastViewController.swift
//  blackbeltreview
//
//  Created by JD Penuliar on 7/23/16.
//  Copyright © 2016 JD Penuliar. All rights reserved.
//

import UIKit
import CoreData
class ToBeastViewController: UITableViewController, CancelButtonDelegate, DoneButtonDelegate, BeastedButtonDelegate{
    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).managedObjectContext
    var toBeastArr = [ToBeast]()
    var addBeastBool = true
    override func viewDidLoad() {
        super.viewDidLoad()
        showToBeast()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("first viewWillAppear")
    }
    //segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddBeastSegue"{
            let navigationController = segue.destination as! UINavigationController
            let beastDetailsViewController = navigationController.topViewController as! BeastDetailsViewController
            beastDetailsViewController.cancelButtonDelegate = self
            beastDetailsViewController.doneButtonDelegate = self
            beastDetailsViewController
            if addBeastBool == false{
                beastDetailsViewController.addBeastStatus = false
                if let indexPath = tableView.indexPath(for: sender as! UITableViewCell){
                    
                    beastDetailsViewController.beastToEditIndexPath = (indexPath as NSIndexPath).row
                    let currentCell = tableView.cellForRow(at: indexPath)! as UITableViewCell
                    beastDetailsViewController.beastToEdit = currentCell.textLabel?.text
                }
            }else{
                beastDetailsViewController.addBeastStatus = true
            }
        }
    }
    //delegates
    func cancelButtonPressedFrom(_ controller: UIViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    func doneButtonPressedFrom(_ controller: UIViewController, didFinishAddingBeast beast: String) {
        let entityToBeast = NSEntityDescription.entity(forEntityName: "ToBeast", in: managedObjectContext)
        let entityToBeastObject = NSManagedObject(entity: entityToBeast!, insertInto: managedObjectContext)
        
        //          add to entity
        entityToBeastObject.setValue(beast, forKey: "toBeast")
        
        
        do{
            try managedObjectContext.save()
        }catch let error as NSError{
            print (error)
        }
        showToBeast()
        dismiss(animated: true, completion: nil)
    }
    
    func doneButtonPressedFrom(_ controller: UIViewController, didFinishAddingBeast beast: String, atIndexPath indexPath: Int) {
        toBeastArr[indexPath].toBeast = beast
        
        
        do {
            try managedObjectContext.save()
        }catch let error as NSError{
            print(error)
        }
        showToBeast()
        dismiss(animated: true, completion: nil)
    }
    
    func beastedButtonPressedFrom(_ customCell: CustomCell, didFinishMovingBeast beasted: String, atIndexPath indexPath: IndexPath){
        //          add to entity
        let date = Date()
        let calendar = Calendar.current
        let components = (calendar as NSCalendar).components([.weekday, .day , .month , .year], from: date)
        
        let year =  components.year
        let month = components.month
        let day = components.day
        let weekday = components.weekday
        
        print(year)
        print(month)
        print(day)
        print (weekday)
        print (components)
        print ("string: \(beasted) and NSIndexpath: \(indexPath)")
        
        let entityBeasted = NSEntityDescription.insertNewObject(forEntityName: "Beasted", into: managedObjectContext) as! Beasted
        entityBeasted.setValue(beasted, forKey: "beasted")
        entityBeasted.setValue(Date(), forKey: "date")
//        entityBeasted

        do{
            try managedObjectContext.save()
        }catch let error as NSError{
            print (error)
        }
        //delete from to beast
        let beastIndex = toBeastArr[(indexPath as NSIndexPath).row]
        managedObjectContext.delete(beastIndex)
        do{
            try managedObjectContext.save()
            showToBeast()
            tableView.reloadData()
        }catch let error as NSError{
            print(error)
        }
    }
    
    
    //delete
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.delete) {
            let beastIndex = toBeastArr[(indexPath as NSIndexPath).row]
            managedObjectContext.delete(beastIndex)
            do{
                try managedObjectContext.save()
                showToBeast()
                tableView.reloadData()
            }catch let error as NSError{
                print(error)
            }
        }
    }
    //table
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.addBeastBool = false
        performSegue(withIdentifier: "AddBeastSegue", sender: tableView.cellForRow(at: indexPath))
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return toBeastArr.count
    }
    //for custom cell
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToBeastCell") as! CustomCell
        cell.customCellText = toBeastArr[(indexPath as NSIndexPath).row].toBeast
        cell.customCellIndexPath = indexPath
        cell.textLabel?.text = toBeastArr[(indexPath as NSIndexPath).row].toBeast
        cell.beastButtonDelegate = self
        return cell
        
    }
    func showToBeast(){
        //swift 2
//        let fetch = NSFetchRequest(entityName: "ToBeast")
        let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: "ToBeast")
        do{
            let result = try managedObjectContext.fetch(fetch)
            toBeastArr = result as! [ToBeast]
            
            tableView.reloadData()
            
        }catch let error as NSError{
            print (error)
        }
        
        
        
        
        
    }
    
}
