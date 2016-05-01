//
//  TimerViewController.swift
//  Lesson25
//
//  Created by Anton Havrylenko on 21.03.16.
//  Copyright © 2016 Havrylenko. All rights reserved.
//

import UIKit

class TimerViewController: UIViewController, TimerMessageDelegate {
    
    // MARK: -Properties
    
    private(set) var duration: NSTimeInterval?
    private(set) var message = "00:00:00"
    private(set) var afterTime: Int?
    private(set) var elapsedTime: NSTimeInterval = 0
    private(set) var internalTimer: NSTimer?
    private(set) var previousTime: NSDate?
    
    @IBOutlet private weak var datePicker: UIDatePicker!
    
    @IBOutlet private weak var pauseButton: UIButton!
    @IBOutlet private weak var startStopButton: UIButton!
    
    @IBOutlet private weak var viewLabel: UIView!
    @IBOutlet private weak var label: UILabel!
    
    // MARK: -Actions
    
    @IBAction func startStop(sender: UIButton) {
        if !startStopButton.selected {
            label.hidden = false
            viewLabel.hidden = false
            startTimer()
        } else {
            resetTimer()
            startStopButton.selected = false
            startStopButton.setTitle("Start", forState: .Normal)
            startStopButton.setTitleColor(UIColor.greenColor(), forState: .Normal)
            label.hidden = true
            viewLabel.hidden = true
        }
    }

    @IBAction func atTheEnd(sender: AnyObject) {
    }

    @IBAction func pause(sender: UIButton) {
        if !pauseButton.selected && startStopButton.selected  {
            pauseButton.setTitle("Go!", forState: .Normal)
            pauseButton.setTitleColor(UIColor.redColor(), forState: .Normal)
            internalTimer?.invalidate()
             pauseButton.selected = true
           } else if startStopButton.selected {
            pauseButton.setTitle("Pause", forState: .Normal)
            pauseButton.setTitleColor(UIColor.greenColor(), forState: .Normal)
            pauseButton.selected = false
             internalTimer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "timerFired:", userInfo: nil, repeats: true)
        }
    }
    
    // MARK: -Override functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "addMessage" {
            let destination = segue.destinationViewController as! TimerMessageViewController
            destination.delegate = self
        }
    }
    
    // MARK: -Private functions
    
    private func startTimer() {
        if !startStopButton.selected {
        start()
        duration = datePicker.countDownDuration as NSTimeInterval
        afterTime = Int(duration!) - Int(duration!) % 60
        startStopButton.selected = true
        startStopButton.setTitle("Cancel", forState: .Normal)
        startStopButton.setTitleColor(UIColor.redColor(), forState: .Normal)
        } else {
            resetTimer()
            startStopButton.setTitle("Start", forState: .Normal)
            startStopButton.setTitleColor(UIColor.greenColor(), forState: .Normal)
        }
    }
    
     private func resetTimer() {
        internalTimer?.invalidate()
        label.text = message
    }
    
    private func update() {
       afterTime! -= 1
        
        let temp = Int(afterTime!)
        let hours = temp / (60 * 60)
        let minutes = Int((temp / 60) - (hours * 60))
        let seconds = temp - (60 * minutes) - (60 * hours * 60)
        label.text = String(format: "%02u : %02u : %02u",  hours, minutes, seconds)
    }
    
    private func timerDidFire() {
        if afterTime == 0 {
            label.text = message
        } else {
            update()
        }
    }
    
    private func start() {
        previousTime = NSDate()
        internalTimer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "timerFired:", userInfo: nil, repeats: true)
    }
    
    // MARK: Convenience functions
    
    func timerFired(timer: NSTimer) {
        if let previousTime = previousTime {
            let elapsed = fabs(previousTime.timeIntervalSinceNow)
            elapsedTime += elapsed
            self.previousTime = NSDate()
            
            timerDidFire()
        }
    }
    
    // MARK: -Delegate functions
    
    func addMessage(message: String) {
        self.message = message
    }
}
