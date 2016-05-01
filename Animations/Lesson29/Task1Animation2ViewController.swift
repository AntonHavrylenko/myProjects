//
//  Task1Animation2ViewController.swift
//  Lesson29
//
//  Created by Anton Havrylenko on 03.04.16.
//  Copyright © 2016 Havrylenko. All rights reserved.
//

import UIKit

class Task1Animation2ViewController: UIViewController {
    
    // MARK: - Properties
    
    private let fullRotation = CGFloat(M_PI * 2)
    
    // MARK: - IBOutlets
    
    @IBOutlet private weak var cat: UIImageView!
    
    // MARK: - Override functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        rotateCat()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Private functions
    
    private func rotateCat() {
        UIView.animateKeyframesWithDuration(2, delay: 0.0, options: .Repeat, animations: {
            
            UIView.addKeyframeWithRelativeStartTime(0, relativeDuration: 1 / 3, animations: {
                self.cat.transform = CGAffineTransformMakeRotation(1 / 3 * self.fullRotation)
            })
           
            UIView.addKeyframeWithRelativeStartTime(1 / 3, relativeDuration: 1 / 3, animations: {
                self.cat.transform = CGAffineTransformMakeRotation(2 / 3 * self.fullRotation)
            })
            
            UIView.addKeyframeWithRelativeStartTime(2 / 3, relativeDuration: 1 / 3, animations: {
                self.cat.transform = CGAffineTransformMakeRotation(3 / 3 * self.fullRotation)
            })
            }, completion:  nil)
    }
    
}
