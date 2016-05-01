//
//  ContactsDetailViewController.swift
//  Lesson33
//
//  Created by Anton Havrylenko on 18.04.16.
//  Copyright © 2016 Havrylenko. All rights reserved.
//

import UIKit

    // MARK: - AddObjectProtocol

protocol AddObjectProtocol {
    func addObject(contact: Contact, index: Int)
}

    // MARK:  - Class ContactDetailsViewController

class ContactDetailsViewController: UIViewController {
    
    // MARK: - Properties
    
    var contact: Contact!
    var index: Int!
    var delegate: ViewController!
    lazy var defaultManager = {
        return NSFileManager.defaultManager()
    }()
    lazy var appSupportDirectory = {
        return try! NSFileManager.defaultManager().URLForDirectory(NSSearchPathDirectory.DocumentDirectory, inDomain: NSSearchPathDomainMask.UserDomainMask, appropriateForURL: nil, create: true)
    }()
    
    // MARK: - IBOutlets
    
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var firstNameTextField: UITextField!
    @IBOutlet private weak var lastNameTextField: UITextField!
    @IBOutlet private weak var numberTextField: UITextField!
    @IBOutlet private weak var emailTextField: UITextField!
    
    // MARK: - IBActions
    
    @IBAction func change(sender: AnyObject) {
        if self.navigationItem.rightBarButtonItem?.title == "Change" {
            self.navigationItem.rightBarButtonItem?.title = "Save"
            
            firstNameTextField.userInteractionEnabled = true
            lastNameTextField.userInteractionEnabled = true
            numberTextField.userInteractionEnabled = true
            emailTextField.userInteractionEnabled = true
            
        } else {
            contact.firstName = firstNameTextField.text!
            contact.lastName = lastNameTextField.text!
            contact.emailAdress = emailTextField.text!
            contact.telephoneNumber = numberTextField.text!
            
            firstNameTextField.userInteractionEnabled = false
            lastNameTextField.userInteractionEnabled = false
            numberTextField.userInteractionEnabled = false
            emailTextField.userInteractionEnabled = false
            
            delegate.dataSource.addContact(contact, index: index)
            
            navigationController?.popToRootViewControllerAnimated(true)
        }
    }
    
    // MARK: - Override functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        firstNameTextField.text = contact.firstName
        lastNameTextField.text = contact.lastName
        emailTextField.text = contact.emailAdress
        numberTextField.text = contact.telephoneNumber
        createImage()
    }
    
    // MARK: - Private functions
    
    private func createImage() {
        let path = appSupportDirectory.URLByAppendingPathComponent(contact.imageViewPath).path!
        
        if defaultManager.fileExistsAtPath(path) && contact.imageViewPath != "" {
            let contentsOfFileData = NSKeyedUnarchiver.unarchiveObjectWithFile(path)
            let data = contentsOfFileData![0]
            imageView.image = data as? UIImage
        }
    }
    
}
