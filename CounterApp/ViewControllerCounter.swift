//
//  ViewControllerCounter.swift
//  CounterApp
//
//  Created by Ondrej Andrysek on 07/11/2016.
//  Copyright © 2016 Ondrej Andrysek. All rights reserved.
//

import UIKit
import CoreData

class ViewControllerCounter: UIViewController {
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelCounter: UILabel!
    
    var indexPathRow : Int = 0
    var addingNumber : Int = 1
    
    var counterObjects = [NSManagedObject]()

    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button10: UIButton!
    @IBOutlet weak var button100: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SetButtonColor(button1)
        //button1.backgroundColor = .clear
        button1.layer.cornerRadius = 0.5 * button1.bounds.size.width
        button1.layer.borderWidth = 3.0
        button1.clipsToBounds = true
        button1.layer.borderColor = UIColor.whiteColor().CGColor
        
        button10.layer.cornerRadius = 0.5 * button1.bounds.size.width
        button10.layer.borderWidth = 3.0
        button10.clipsToBounds = true
        button1.layer.borderColor = UIColor.whiteColor().CGColor
        
        button100.layer.cornerRadius = 0.5 * button1.bounds.size.width
        button100.layer.borderWidth = 3.0
        button100.clipsToBounds = true
        button1.layer.borderColor = UIColor.whiteColor().CGColor
        //button1.titleEdgeInsets
        //button1.layer.borderColor = UIColor.black.cgColor
        // Do any additional setup after loading the view.
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
        labelCounter.text = (counterObjects[indexPathRow].valueForKey("counterNumber") as? NSNumber)?.stringValue
    }
    
    func SetCounter(number : Int){
        
        let counter = counterObjects[indexPathRow]
        
        let result = (counter.valueForKey("counterNumber") as? Int)! + number
        
        counter.setValue(result, forKey: "counterNumber")
        
        do {
            try counter.managedObjectContext?.save()
        }   catch let error as NSError{
            print("Couldn't save \(error)")
        }
        labelCounter.text = (counter.valueForKey("counterNumber") as? NSNumber)?.stringValue
    }
    
    @IBAction func PlusButton(sender: AnyObject) {
        SetCounter(addingNumber)
    }
    
    @IBAction func MinusButton(sender: AnyObject) {
        SetCounter(addingNumber*(-1))
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
        button1.setTitleColor(UIColor.grayColor(), forState: UIControlState.Normal)
        button1.layer.borderColor = UIColor.grayColor().CGColor
        button10.setTitleColor(UIColor.grayColor(), forState: UIControlState.Normal)
        button10.layer.borderColor = UIColor.grayColor().CGColor
        button100.setTitleColor(UIColor.grayColor(), forState: UIControlState.Normal)
        button100.layer.borderColor = UIColor.grayColor().CGColor
        button.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        button.layer.borderColor = UIColor.whiteColor().CGColor
    }
    

}

extension UIColor{
    static func appleBlue() -> UIColor{
        return UIColor.init(colorLiteralRed: 14.0/255, green: 122.0/255, blue: 254.0/255, alpha: 1.0)
    }
}
