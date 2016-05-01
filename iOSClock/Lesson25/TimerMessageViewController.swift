//
//  TimerMessageViewController.swift
//  Lesson25
//
//  Created by Anton Havrylenko on 22.03.16.
//  Copyright © 2016 Havrylenko. All rights reserved.
//

import UIKit

protocol TimerMessageDelegate {
    func addMessage(message: String)
}

class TimerMessageViewController: UIViewController {

    var delegate: TimerMessageDelegate? = nil
    
    @IBAction func timeMessage(sender: UIButton) {
        if let message = sender.currentTitle {
            delegate?.addMessage(message)
            self.navigationController?.popToRootViewControllerAnimated(true)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
