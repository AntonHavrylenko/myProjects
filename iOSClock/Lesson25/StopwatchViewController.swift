//
//  StopwatchViewController.swift
//  Lesson25
//
//  Created by Anton Havrylenko on 20.03.16.
//  Copyright © 2016 Havrylenko. All rights reserved.
//

import UIKit

class StopwatchViewController: UIViewController {
    
    let stopwatch = Stopwatch()
    
    private(set) var history = [String]()
    
    @IBOutlet private weak var finalTimeLabel: UILabel!
    
    @IBOutlet private weak var startStopButton: UIButton!
    
    // MARK: -Actions
    
    @IBAction func historyButtonAction(sender: UIButton) {
        
    }
    
    @IBAction private func startStopButtonAction(sender: AnyObject) {
        if !startStopButton.selected {
            NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: "updateFinalTimeLabel:", userInfo: nil, repeats: true)
            stopwatch.start()
            startStopButton.selected = true
            startStopButton.setTitle("Stop", forState: .Normal)
            startStopButton.setTitleColor(UIColor.redColor(), forState: .Normal)
        } else {
            stopwatch.stop()
            startStopButton.selected = false
            startStopButton.setTitle("Start", forState: .Normal)
            startStopButton.setTitleColor(UIColor.greenColor(), forState: .Normal)
            if let text = finalTimeLabel.text {
            history.append(text)
            }
        }
        
    }
    
    // MARK: -Override functions
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "addHistory" {
            let destination = segue.destinationViewController as! HistoryViewController
            destination.histories = history
        }
    }
    
    // MARK: Convenience functions
    
    func updateFinalTimeLabel(timer: NSTimer) {
        if stopwatch.isRunning {
            finalTimeLabel.text = stopwatch.finalTimeAsString
        } else {
            timer.invalidate()
        }
    }
    
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}
