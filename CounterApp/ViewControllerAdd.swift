//
//  ViewControllerAdd.swift
//  CounterApp
//
//  Created by Ondrej Andrysek on 21/11/2016.
//  Copyright © 2016 Ondrej Andrysek. All rights reserved.
//

import UIKit
import CoreData

class ViewControllerAdd: UIViewController {
    @IBOutlet weak var textFieldTitle: UITextField!
    @IBOutlet weak var textFieldNumber: UITextField!
    @IBOutlet weak var textFieldGoal: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        let imageView = UIImageView(frame: UIScreen.mainScreen().bounds)
        imageView.image = UIImage(named: "background")
        self.view.insertSubview(imageView, atIndex: 0)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func AddButtonTouched(sender: AnyObject) {
        var title = ""
        var number : Int16 = 0
        var goal : Int16 = 0
        if(textFieldTitle.text != ""){
            title = textFieldTitle.text!
        }
        else {
            print("error")
            return
        }
        
        if(textFieldNumber.text == ""){
            number = 0
        }
        else {
            number = Int16(textFieldNumber.text!)!
        }
        
        if(textFieldGoal.text == ""){
            goal = 0
        }
        else {
            goal = Int16(textFieldGoal.text!)!
        }
        
        SaveCounter(title, number: number, goal: goal)
        
        navigationController?.popViewControllerAnimated(true)
    }
    
    func SaveCounter(title: String, number: Int16, goal: Int16){
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext
        
        let entity = NSEntityDescription.entityForName("Counter", inManagedObjectContext: managedContext)
        
        let counter = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: managedContext)
        
        
        counter.setValue(title, forKey: "title")
        counter.setValue(NSNumber(short: number), forKey: "counterNumber")
        counter.setValue(NSNumber(short: goal), forKey: "goalNumber")
        
        do{
            try managedContext.save()
        } catch let error as NSError{
            print("Couldn't save \(error)")
        }
    }
    

}
