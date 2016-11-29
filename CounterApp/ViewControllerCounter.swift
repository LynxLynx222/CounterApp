//
//  ViewControllerCounter.swift
//  CounterApp
//
//  Created by Ondrej Andrysek on 07/11/2016.
//  Copyright © 2016 Ondrej Andrysek. All rights reserved.
//

import UIKit
import CoreData

//VIEW CONTROLLER TO DISPLAY COUNTER, INCREASE OR DECREASE BY PRESSING + OR - BUTTON, SET ADDING VALUE BY PRESSING 1, 10 OR 100 BUTTON

class ViewControllerCounter: UIViewController {
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelCounter: UILabel!
    @IBOutlet weak var labelProgressBar: UILabel!
    
    @IBOutlet weak var progressBar: UIProgressView!

    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button10: UIButton!
    @IBOutlet weak var button100: UIButton!
    
    private var indexPathRow : Int = 0
    private var addingNumber : Int = 1
    
    private var counterObjects = [NSManagedObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SetInitialLookButton(button1)
        SetInitialLookButton(button10)
        SetInitialLookButton(button100)
        SetButtonColor(button1)
        
        let imageView = UIImageView(frame: UIScreen.mainScreen().bounds)
        imageView.image = UIImage(named: "background")
        self.view.insertSubview(imageView, atIndex: 0)
        
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    
        SetLabels()
    
    }
    
    
    func AddNumber(number : Int){
        
        let counter = counterObjects[indexPathRow]
        
        let result = (counter.valueForKey("counterNumber") as? Int)! + number
        
        counter.setValue(result, forKey: "counterNumber")
        
        do {
            try counter.managedObjectContext?.save()
        }   catch let error as NSError{
            print("Couldn't save \(error)")
        }
        SetLabels()
    }
    
    //BUTTONS
    @IBAction func PlusButton(sender: AnyObject) {
        AddNumber(addingNumber)
    }
    
    @IBAction func MinusButton(sender: AnyObject) {
        AddNumber(addingNumber*(-1))
    }
    
    @IBAction func button1(sender: AnyObject) {
        SetButtonColor(button1)
        addingNumber = 1
    }
    @IBAction func button10(sender: AnyObject) {
        SetButtonColor(button10)
        addingNumber = 10
    }
    @IBAction func button100(sender: AnyObject) {
        
        SetButtonColor(button100)
        addingNumber = 100
    }
    
    
    
    func SetButtonColor(button : UIButton){
        button1.setTitleColor(UIColor.darkGrayColor(), forState: UIControlState.Normal)
        button1.layer.borderColor = UIColor.darkGrayColor().CGColor
        button10.setTitleColor(UIColor.darkGrayColor(), forState: UIControlState.Normal)
        button10.layer.borderColor = UIColor.darkGrayColor().CGColor
        button100.setTitleColor(UIColor.darkGrayColor(), forState: UIControlState.Normal)
        button100.layer.borderColor = UIColor.darkGrayColor().CGColor
        button.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        button.layer.borderColor = UIColor.whiteColor().CGColor
    }
    
    func SetInitialLookButton(button : UIButton){
        button.layer.cornerRadius = 0.5 * button.bounds.size.width
        button.layer.borderWidth = 3.0
        button.clipsToBounds = true
        button.layer.borderColor = UIColor.whiteColor().CGColor
    }
    
    func SetLabels(){
        labelCounter.text = (counterObjects[indexPathRow].valueForKey("counterNumber") as? NSNumber)?.stringValue
        
        let number = (counterObjects[indexPathRow].valueForKey("counterNumber") as? NSNumber)!.integerValue
        let goal = (counterObjects[indexPathRow].valueForKey("goalNumber") as? NSNumber)?.floatValue
        
        if(goal == 0){
            labelProgressBar.hidden = true
            progressBar.hidden = true
        }
            
        else{
            if(Float(number) < goal){
                let progressNumber : Float = (Float(number))/(goal)!
                progressBar.setProgress(progressNumber, animated: true)
                labelProgressBar.text = String(Int(progressNumber * 100)) + "%"
            }
                
            else{
                progressBar.setProgress(1.0, animated: true)
                labelProgressBar.text = "100%"
            }
        }
    }
    
    func SetIndexPathRow(indexRow : Int){
        indexPathRow = indexRow
    }
    

}

