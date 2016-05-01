//
//  SettingsViewController.swift
//  Lesson33
//
//  Created by Anton Havrylenko on 21.04.16.
//  Copyright © 2016 Havrylenko. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    // MARK: - Properties
    
    let userDefaults = NSUserDefaults.standardUserDefaults()
    
    // MARK: - IBOutlets
    
    @IBOutlet private weak var backgroundSwitchOutlet: UISwitch!
    @IBOutlet private weak var sequenceSwitchOutlet: UISwitch!
    
    // MARK: - IBActions
    
    @IBAction func backgroundSwitch(sender: UISwitch) {
        if sender.on {
            userDefaults.setBool(true, forKey: Color)
        } else {
            userDefaults.setBool(false, forKey: Color)
        }
        
        userDefaults.synchronize()
    }
    
    @IBAction func sequenceSwitch(sender: UISwitch) {
        if sender.on {
            userDefaults.setBool(true, forKey: Sequence)
        } else {
            userDefaults.setBool(false, forKey: Sequence)
        }
        
        userDefaults.synchronize()
    }
    
    // MARK: - Override functions
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        if userDefaults.boolForKey(Color) {
            backgroundSwitchOutlet.on = true
            
        } else {
            backgroundSwitchOutlet.on = false
        }
        
        if userDefaults.boolForKey(Sequence) {
            sequenceSwitchOutlet.on = true
            
        } else {
            sequenceSwitchOutlet.on = false
        }
    }
    
}
