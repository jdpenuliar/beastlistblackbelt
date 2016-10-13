//
//  BeastedViewController.swift
//  blackbeltreview
//
//  Created by JD Penuliar on 7/24/16.
//  Copyright © 2016 JD Penuliar. All rights reserved.
//

import UIKit
import CoreData
class BeastedViewController: UITableViewController{
    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).managedObjectContext
    var beastedArr = [Beasted]()
    var tempArr = [Date]()
    override func viewDidLoad() {
        super.viewDidLoad()
        showBeasted()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print ("second view controller")
        showBeasted()
    }

    
    //table
//    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
//        return true
//    }
//    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
//        if (editingStyle == UITableViewCellEditingStyle.Delete) {
//            let beastIndex = beastedArr[indexPath.row]
//            managedObjectContext.deleteObject(beastIndex)
//            do{
//                try managedObjectContext.save()
//                showBeasted()
//                tableView.reloadData()
//            }catch let error as NSError{
//                print(error)
//            }
//        }
//    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return beastedArr.count
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        showBeasted()
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BeastedCell")!
        cell.textLabel?.text = beastedArr[(indexPath as NSIndexPath).row].beasted

        let date = tempArr[(indexPath as NSIndexPath).row]
        let calendar = Calendar.current
        let components = (calendar as NSCalendar).components([.weekday, .day , .month , .year], from: date)
        var dayOfWeek: String?
        var monthOfYear: String?
        
        if components.weekday == 1{
            dayOfWeek = "Sunday"
        }else if components.weekday == 2{
            dayOfWeek = "Monday"
        }else if components.weekday == 3{
            dayOfWeek = "Tuesday"
        }else if components.weekday == 4{
            dayOfWeek = "Wednessday"
        }else if components.weekday == 5{
            dayOfWeek = "Thursday"
        }else if components.weekday == 6{
            dayOfWeek = "Friday"
        }else if components.weekday == 7{
            dayOfWeek = "Saturday"
        }
        
        if components.month == 1{
            monthOfYear = "January"
        }else if components.month == 2{
            monthOfYear = "February"
        }else if components.month == 3{
            monthOfYear = "March"
        }else if components.month == 4{
            monthOfYear = "April"
        }else if components.month == 5{
            monthOfYear = "May"
        }else if components.month == 6{
            monthOfYear = "June"
        }else if components.month == 7{
            monthOfYear = "July"
        }else if components.month == 8{
            monthOfYear = "August"
        }else if components.month == 9{
            monthOfYear = "September"
        }else if components.month == 10{
            monthOfYear = "October"
        }else if components.month == 11{
            monthOfYear = "November"
        }else if components.month == 12{
            monthOfYear = "December"
        }
        
        
        cell.detailTextLabel?.text = "\(dayOfWeek!) \(monthOfYear!) \(components.day)"
        
        
        
        return cell
        
    }
    
    func showBeasted(){
      
        
//        let fetch = NSFetchRequest(entityName: "Beasted")
        
        let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Beasted")
        
        do{
            let result = try managedObjectContext.fetch(fetch)
            beastedArr = result as! [Beasted]
            //swift 2
//            for managedObjecthaha in result {
//                if let beastedString = managedObjecthaha.value(forKey: "beasted"), let beastedDate = managedObjecthaha.value(forKey: "date") {
//                    
//                    print("\(beastedString) \(beastedDate)")
//                    tempArr.append(beastedDate as! Date)
//                    
//                }
//            }
            
            for managedObjecthaha in result {
                if let beastedString = (managedObjecthaha as AnyObject).value(forKey: "beasted"), let beastedDate = (managedObjecthaha as AnyObject).value(forKey: "date") {
                    
                    print("\(beastedString) \(beastedDate)")
                    tempArr.append(beastedDate as! Date)
                    
                }
            }

            
            print ("haha")
            print ("haha")
            print ("haha")
            print ("haha")
            print (beastedArr)
            print (tempArr
            )
        }catch let error as NSError{
            print (error)
        }

        
        
        
    }
}
