//
//  Task2ViewController.swift
//  Lesson29
//
//  Created by Anton Havrylenko on 04.04.16.
//  Copyright © 2016 Havrylenko. All rights reserved.
//

import UIKit

class Task2ViewController: UIViewController {
    
    // MARK: - Properties
    
    private let constraintOfHiddenMenu: CGFloat = 30
    private let constraintOfOpenMenu: CGFloat = 250
    private(set) var data = [String]()
    
    // MARK: - IBOutlets
    
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var comboBoxHeightConstraint: NSLayoutConstraint!
    @IBOutlet private weak var comboBoxView: UIView!
    @IBOutlet private weak var firstButton: UIButton!
    @IBOutlet private weak var tableView: UITableView!
    
    // MARK: - Actions
    
    @IBAction func firstButtonTapped(sender: UIButton) {
        if !sender.selected {
            appearMenu()
            sender.selected = true
        } else {
            disappearMenu()
            sender.selected = false
        }
    }
    
    // MARK: - Override functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        comboBoxView.layer.borderWidth = 1
        comboBoxView.layer.borderColor = UIColor.lightGrayColor().CGColor
        
        data = ["question 1", "question 2", "question 3", "question 4", "question 5"]
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Private functions
    
    private func appearMenu() {
        imageView.image = UIImage(named: "arrow-up-2")
        view.layoutIfNeeded()
        
        UIView.animateWithDuration(0.5, delay: 0, options: .CurveEaseInOut, animations: {
            self.comboBoxHeightConstraint.constant = self.constraintOfOpenMenu
            self.view.layoutIfNeeded()
            }, completion: nil)
    }
    
    private func disappearMenu() {
        imageView.image = UIImage(named: "arrow-down-2")
        view.layoutIfNeeded()
        
        UIView.animateWithDuration(0.5, delay: 0, options: .CurveEaseInOut, animations: {
            self.comboBoxHeightConstraint.constant = self.constraintOfHiddenMenu
            self.view.layoutIfNeeded()
            }, completion: nil)
    }
    
}

// MARK: - Extension with UITableViewDelegate, UITableViewDataSource

extension Task2ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        cell.textLabel!.text = data[indexPath.row]
        cell.textLabel?.textColor = UIColor.darkGrayColor()
        
        return cell
    }
    
}