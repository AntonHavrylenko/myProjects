//
//  ViewController.swift
//  Lesson33
//
//  Created by Anton Havrylenko on 18.04.16.
//  Copyright © 2016 Havrylenko. All rights reserved.
//

import UIKit

// MARK: - Constants

let CounterKey = "CounterKey"
let Key = "Key"
let Color = "Color"
let Sequence = "Sequence"


class ViewController: UITableViewController {
    
    // MARK: - Properties
    
    var dataSource = ContactsDataSource()
    var userDefaults = NSUserDefaults.standardUserDefaults()
    lazy var documentDir: AnyObject = {
        return NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)[0]
    }()
    
    // MARK: - IBActions
    
    @IBAction func cancel(segue: UIStoryboardSegue) {
        dispatch_async(dispatch_get_main_queue(), {
            self.dismissViewControllerAnimated(true, completion: nil)
        })
    }
    
    @IBAction func save(segue: UIStoryboardSegue) {
        let source = segue.sourceViewController as! AddContactViewController
        
        if source.newContact.firstName != "" || source.newContact.lastName != "" {
            dataSource.addContact(source.newContact, index: dataSource.contacts.count)
            
            tableView.reloadData()
            
            dispatch_async(dispatch_get_main_queue(), {
                self.dismissViewControllerAnimated(true, completion: nil)
            })
        }
    }
    
    // MARK: - Override functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource.createFolder()
        
        dataSource.getContacts()
        
        showAllert()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tableView.reloadData()
    }
    
    // MARK: - Private functions
    
    private func removeFolder() {
        do {
            try NSFileManager.defaultManager().removeItemAtPath(documentDir as! String)
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    private func showAllert() {
        let defaults = NSUserDefaults.standardUserDefaults()

        if defaults.boolForKey(Key) {
            return
        }
        
        var count = defaults.integerForKey(CounterKey)
        
        count += 1
        
        if count == 3 {
            count = 0
            allAllertProcess()
        }
        
        defaults.setInteger(count, forKey: CounterKey)
        defaults.synchronize()
    }
    
    private func allAllertProcess() {
        let message = "If You like this app, please give us 5 stars on App Store"
        
        let appStoreAlert = UIAlertController(title:"Rate this app", message: message as String, preferredStyle: .Alert)
        
        appStoreAlert.addAction(UIAlertAction(title: "Go to App Store", style:.Default, handler: { UIAlertAction in
            self.stopedAllert()
            
            dispatch_async(dispatch_get_main_queue(), {
                UIApplication.sharedApplication().openURL(NSURL(string:"http://www.apple.com")!)
            })
        }))
        
        appStoreAlert.addAction(UIAlertAction(title: "Remind me later", style:.Default, handler: nil))
        
        appStoreAlert.addAction(UIAlertAction(title: "I don't like it", style:.Default, handler: { UIAlertAction in
            self.stopedAllert()
        }))
        
        dispatch_async(dispatch_get_main_queue(), {
            self.presentViewController(appStoreAlert, animated: true, completion: nil)
        })
        
    }
    
    private func stopedAllert() {
        let defaults = NSUserDefaults.standardUserDefaults()
        
        defaults.setBool(true, forKey: Key)
        defaults.synchronize()
    }

    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.countOfContacts()
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        
        let currentIndex = indexPath.row
        let tempContact = dataSource.contactAtIndex(currentIndex)
        
        if !userDefaults.boolForKey(Color) {
            cell.textLabel?.textColor = UIColor.blackColor()
            cell.detailTextLabel?.textColor = UIColor.blackColor()
            cell.backgroundColor = UIColor.whiteColor()
            
        } else {
            cell.textLabel?.textColor = UIColor.whiteColor()
            cell.detailTextLabel?.textColor = UIColor.whiteColor()
            cell.backgroundColor = UIColor.darkGrayColor()
        }
        
        if !userDefaults.boolForKey(Sequence) {
            cell.textLabel?.text = tempContact.lastName
            cell.detailTextLabel?.text = tempContact.firstName
            
        } else {
            cell.textLabel?.text = tempContact.firstName
            cell.detailTextLabel?.text = tempContact.lastName
        }
        
        return cell
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            dataSource.deleteContactAtIndex(indexPath.row)
            
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        }
    }
    
    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "contactDetailsSegue" {
            let selectedIndex = tableView.indexPathForSelectedRow?.row
            let selectedContact = dataSource.contactAtIndex(selectedIndex!)
           
            let destination = segue.destinationViewController as! ContactDetailsViewController
            destination.contact = selectedContact
            destination.index = selectedIndex
            destination.delegate = self
        }
    }
    
}

extension ViewController: AddObjectProtocol {
    func addObject(contact: Contact, index: Int) {
        dataSource.addContact(contact, index: index)
    }
    
}
