//
//  ClockViewController.swift
//  Lesson25
//
//  Created by Anton Havrylenko on 20.03.16.
//  Copyright © 2016 Havrylenko. All rights reserved.
//

import UIKit

protocol DestinationDelegate {
    func addEditTime(city: String)
  }

class ClockViewController: UIViewController {
    
    var delegate: DestinationDelegate? = nil
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func city(sender: UIButton) {
        if let sender = sender.currentTitle {
            delegate?.addEditTime(sender)
            self.navigationController?.popToRootViewControllerAnimated(true)
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
