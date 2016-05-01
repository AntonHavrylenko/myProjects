//
//  Task1Animation1ViewController.swift
//  Lesson29
//
//  Created by Anton Havrylenko on 03.04.16.
//  Copyright © 2016 Havrylenko. All rights reserved.
//

import UIKit

class Task1Animation1ViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet private weak var blueBottomConstraint: NSLayoutConstraint!
    @IBOutlet private weak var greenTopConstraint: NSLayoutConstraint!
    @IBOutlet private weak var greenBottomConstraint: NSLayoutConstraint!
    @IBOutlet private weak var lavenderTopConstraint: NSLayoutConstraint!
    @IBOutlet private weak var lavenderBottomConstraint: NSLayoutConstraint!
    
    // MARK: - Override functions
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        animateShapes()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Private functions
    
    private func animateShapes() {
        self.view.layoutIfNeeded()
        
        animateBlueShape()
        animateLavanderShape()
        animateGreenShape()
    }
    
    private func animateBlueShape() {
        UIView.animateWithDuration(1, delay: 0.0, options: .CurveEaseOut, animations: {
            self.blueBottomConstraint.priority = UILayoutPriorityDefaultHigh
            self.view.layoutIfNeeded()
            }, completion: nil)
        
        UIView.animateWithDuration(1, delay: 1.1, options: .CurveEaseOut, animations: {
            self.blueBottomConstraint.priority = UILayoutPriorityDefaultLow
            self.view.layoutIfNeeded()
            }, completion: nil)
    }
    
    private func animateLavanderShape() {
        UIView.animateWithDuration(1, delay: 2.2, options: .CurveEaseOut, animations: {
            self.lavenderTopConstraint.priority = UILayoutPriorityDefaultHigh
            self.lavenderBottomConstraint.priority = UILayoutPriorityDefaultHigh
            self.view.layoutIfNeeded()
            }, completion: nil)
        
        UIView.animateWithDuration(1, delay: 3.3, options: .CurveEaseOut, animations: {
            self.lavenderTopConstraint.priority = UILayoutPriorityDefaultLow
            self.lavenderBottomConstraint.priority = UILayoutPriorityDefaultLow
            self.view.layoutIfNeeded()
            }, completion: nil)
    }
    
    private func animateGreenShape() {
        UIView.animateWithDuration(1, delay: 4.4, options: .CurveEaseOut, animations: {
            self.greenTopConstraint.priority = UILayoutPriorityDefaultHigh
            self.greenBottomConstraint.priority = UILayoutPriorityDefaultHigh
            self.view.layoutIfNeeded()
            }, completion: nil)
        
        UIView.animateWithDuration(1, delay: 5.5, options: .CurveEaseOut, animations: {
            self.greenTopConstraint.priority = UILayoutPriorityDefaultLow
            self.greenBottomConstraint.priority = UILayoutPriorityDefaultLow
            self.view.layoutIfNeeded()
            }, completion: nil)
    }
    
}
