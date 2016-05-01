//
//  HistoryViewController.swift
//  Lesson25
//
//  Created by Anton Havrylenko on 20.03.16.
//  Copyright © 2016 Havrylenko. All rights reserved.
//

import UIKit


class HistoryViewController: UIViewController{

    @IBOutlet private var historyLabels: [UILabel]!
    var histories = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hiddenLabels()
        addHistory()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func hiddenLabels() {
        for label in historyLabels {
            label.hidden = true
        }
    }
    
    func addHistory() {
        while !histories.isEmpty {
            var status = false
            
            for label in historyLabels {
                if histories.isEmpty {
                    break
                }
                
                if label.hidden {
                    label.hidden = false
                    label.text = histories.removeFirst()
                    status = true
                }
            }
            
            if !status {
                hiddenLabels()
            }
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
