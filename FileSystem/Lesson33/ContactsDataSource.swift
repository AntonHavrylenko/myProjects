//
//  ContactsDataSource.swift
//  Lesson33
//
//  Created by Anton Havrylenko on 18.04.16.
//  Copyright © 2016 Havrylenko. All rights reserved.
//

import Foundation
import UIKit

class ContactsDataSource {
    
    // MARK: - Properties
    
    let pathContacts = NSMutableArray()
    let contacts = NSMutableArray()
    lazy var appSupportDirectory = {
        return try! NSFileManager.defaultManager().URLForDirectory(NSSearchPathDirectory.DocumentDirectory, inDomain: NSSearchPathDomainMask.UserDomainMask, appropriateForURL: nil, create: true)
    }()
    lazy var fileManager = {
        return NSFileManager.defaultManager()
    }()
    
    // MARK: - Convenience functions
    
    func countOfContacts() -> Int {
        return contacts.count
    }
    
    func contactAtIndex(index: Int) -> Contact {
        let tempContact = contacts.objectAtIndex(index) as! Contact
        
        return tempContact
    }
    
    func addContact(contact: Contact, index: Int) {
        saveContacts(contact, index: index)
    }
    
    func deleteContactAtIndex(index: Int) {
        let path = appSupportDirectory.URLByAppendingPathComponent(pathContacts[index] as! String)
        let pathForImage = appSupportDirectory.URLByAppendingPathComponent((contacts[index] as! Contact).imageViewPath)
        
        if fileManager.fileExistsAtPath(pathForImage.path!) && ((contacts[index] as! Contact).imageViewPath != "") {
            do {
                try fileManager.removeItemAtURL(pathForImage)
                
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
        
        do {
            try fileManager.removeItemAtURL(path)
            
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        
        pathContacts.removeObjectAtIndex(index)
        contacts.removeObjectAtIndex(index)
        
        saveContactsAfterRemove()
    }
    
    func getFileURLPath() -> NSURL {
        let fileURL = appSupportDirectory.URLByAppendingPathComponent("Contacts/adressBook.data")
        
        return fileURL
    }
    
    func saveContactsAfterRemove() {
        let filePath = getFileURLPath().path!
        NSKeyedArchiver.archiveRootObject(pathContacts, toFile: filePath)
    }
    
    func saveContacts(contact: Contact, index: Int) {
        if let data = contact.imageData {
            let imageName = arc4random()
            let fileImageURL = appSupportDirectory.URLByAppendingPathComponent("Contacts/\(imageName).plist")
            let imageArray = NSMutableArray()
            let image = UIImage(data: data)
            imageArray.addObject(image!)
            contact.imageViewPath = "Contacts/\(imageName).plist"
            NSKeyedArchiver.archiveRootObject(imageArray, toFile: fileImageURL.path!)
        }
        
        if index == contacts.count {
            let name = arc4random()
            let fileURL = appSupportDirectory.URLByAppendingPathComponent("Contacts/\(name).plist")
            
            let array = NSMutableArray()
            array.addObject(contact)
            
            pathContacts.addObject("Contacts/" + String(name) + ".plist")
            contacts.addObject(contact)
            
            NSKeyedArchiver.archiveRootObject(array, toFile: fileURL.path!)
            
            let filePath = getFileURLPath().path!
            NSKeyedArchiver.archiveRootObject(pathContacts, toFile: filePath)
            
        } else {
            contacts.replaceObjectAtIndex(index, withObject: contact)
            
            let array = NSMutableArray()
            array.addObject(contact)
            
            let fileURL = appSupportDirectory.URLByAppendingPathComponent(pathContacts[index] as! String)
            
            NSKeyedArchiver.archiveRootObject(array, toFile: fileURL.path!)
        }
    }
    
    func getContacts() {
        let filePath = getFileURLPath().path!
        
        if fileManager.fileExistsAtPath(filePath) {
            let contentsOfFile = NSKeyedUnarchiver.unarchiveObjectWithFile(filePath)
            pathContacts.addObjectsFromArray(contentsOfFile as! [AnyObject])
        }
        
        for value in pathContacts {
            let fileURL = appSupportDirectory.URLByAppendingPathComponent(value as! String)
            
            if fileManager.fileExistsAtPath(fileURL.path!) {
                let contentsOfFile = NSKeyedUnarchiver.unarchiveObjectWithFile(fileURL.path!)
                contacts.addObject(contentsOfFile![0])
            }
        }
    }
    
    func createFolder() {
        let paths = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
        let documentsDirectory: AnyObject = paths[0]
        let dataPath = documentsDirectory.stringByAppendingPathComponent("Contacts")
        
        do {
            try NSFileManager.defaultManager().createDirectoryAtPath(dataPath, withIntermediateDirectories: false, attributes: nil)
            
        } catch let error as NSError {
            print(error.localizedDescription);
        }
    }
    
}
