//
//  Task1Animation4ViewController.swift
//  Lesson29
//
//  Created by Anton Havrylenko on 03.04.16.
//  Copyright © 2016 Havrylenko. All rights reserved.
//

import UIKit

class Task1Animation4ViewController: UIViewController {
    
    // MARK: - Properties
    
    private(set) var status = false
    
    // MARK: - IBOutlets
    
    @IBOutlet private var menuButtonConstraints: [NSLayoutConstraint]!
    @IBOutlet private weak var menuTopConstraint: NSLayoutConstraint!
    @IBOutlet private weak var menuBottomConstraint: NSLayoutConstraint!
    
    // MARK: - Actions
    
    @IBAction private func buttonTapped(sender: UIBarButtonItem) {
        if !status {
            appearMenu()
            status = true
        } else {
            status = false
            disappearMenu()
        }
    }
    
    // MARK: - Override functions
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        menuTopConstraint.constant += view.bounds.height
        
        for value in menuButtonConstraints {
            value.constant += view.bounds.width
        }
        
        self.view.layoutIfNeeded()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Private functions
    
    private func appearMenu() {
        self.view.layoutIfNeeded()
        
        UIView.animateWithDuration(0.5, delay: 0.0, options: .CurveEaseOut, animations: {
            self.menuTopConstraint.constant -= self.view.bounds.height
            self.view.layoutIfNeeded()
            }, completion: nil)
        
        UIView.animateWithDuration(0.5, delay: 0.5, options: .CurveEaseOut, animations: {
            for value in self.menuButtonConstraints {
                value.constant -= self.view.bounds.width
            }
            
            self.view.layoutIfNeeded()
            }, completion: nil)
    }
    
    private func disappearMenu() {
        self.view.layoutIfNeeded()
        
        UIView.animateWithDuration(0.5, delay: 0.0, options: .CurveEaseOut, animations: {
            self.menuTopConstraint.constant += self.view.bounds.height
            self.view.layoutIfNeeded()
            }, completion: nil)
        
        UIView.animateWithDuration(0.2, delay: 0.0, options: .CurveEaseOut, animations: {
            for value in self.menuButtonConstraints {
                value.constant += self.view.bounds.width
            }
            
            self.view.layoutIfNeeded()
            }, completion: nil)
    }
    
}
