//
//  ViewController.swift
//  Lesson25
//
//  Created by Anton Havrylenko on 19.03.16.
//  Copyright © 2016 Havrylenko. All rights reserved.
//

import UIKit



class ViewController: UIViewController, DestinationDelegate {
    
    let clock = Clock()
    var result = String()
    var timer: NSTimer?
    
    @IBOutlet private var city1: [UILabel]!
    @IBOutlet private var city2: [UILabel]!
    @IBOutlet private var city3: [UILabel]!
    @IBOutlet private var city4: [UILabel]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: "updateTimeLabel", userInfo: nil, repeats: true)
        city1[0].text = "Uzhgorod"
        city1[2].text = NSTimeZone.systemTimeZone().description
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "addEditTime" {
            let destination = segue.destinationViewController as! ClockViewController
            destination.delegate = self
        }
    }
    
    func updateTimeLabel() {
        let formatter = NSDateFormatter()
        formatter.timeStyle = .MediumStyle
        city1[1].text = formatter.stringFromDate(clock.currentTime)
    }
    
    func addEditTime(city: String) {

    }
   
}

