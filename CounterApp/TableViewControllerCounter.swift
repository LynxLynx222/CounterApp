//
//  TableViewControllerCounter.swift
//  CounterApp
//
//  Created by Ondrej Andrysek on 28/10/2016.
//  Copyright © 2016 Ondrej Andrysek. All rights reserved.
//

import UIKit
import CoreData

//TABLEVIEW CONTROLLER TO DISPLAY ALL COUNTERS FROM CORE DATA

class TableViewControllerCounter: UITableViewController {
    
    private var counterObjects = [NSManagedObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let imageView = UIImageView(frame: self.view.frame)
        imageView.image = UIImage(named: "background")
        self.tableView.backgroundView = imageView
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension TableViewControllerCounter{
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return counterObjects.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        
        let counter = counterObjects[indexPath.row]
        
        let counterNum = String(counter.valueForKey("counterNumber") as! NSNumber)
        
        cell.textLabel?.text = counter.valueForKey("title") as? String
        cell.textLabel?.textColor = UIColor.whiteColor()
        cell.detailTextLabel?.text = counterNum
        cell.detailTextLabel?.textColor = UIColor.whiteColor()
        
        return cell
    }
    
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        cell.backgroundColor = .clearColor()
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext
        
        if editingStyle == UITableViewCellEditingStyle.Delete{
            
            do{
            managedContext.deleteObject(counterObjects[indexPath.row])
            try managedContext.save()
            }   catch{
                    print("error")
            }
            counterObjects.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext
        
        let fetchRequest = NSFetchRequest(entityName: "Counter")
        
        do{
            let results = try managedContext.executeFetchRequest(fetchRequest)
            counterObjects = results as! [NSManagedObject]
        }   catch let error as NSError{
            print("Couldn't save \(error)")
        }
        
        tableView.tableFooterView = UIView(frame: CGRectZero)
        
        self.tableView.reloadData()
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let indexPath = self.tableView.indexPathForSelectedRow
        if segue.identifier == "VCCounter"{
            let destView = segue.destinationViewController as! ViewControllerCounter
        
            destView.SetIndexPathRow(indexPath!.row)
        
        }
        
    }
}

