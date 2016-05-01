//
//  AddContactViewController.swift
//  Lesson33
//
//  Created by Anton Havrylenko on 18.04.16.
//  Copyright © 2016 Havrylenko. All rights reserved.
//

import UIKit

class AddContactViewController: UITableViewController {
    
    // MARK: - Properties
    
    var newContact = Contact()
    var picker: UIImagePickerController? = UIImagePickerController()
    var popover: UIPopoverController? = nil
    
    // MARK: - IBOutlets
    
    @IBOutlet private weak var firstNameTextField: UITextField!
    @IBOutlet private weak var lastNameTextField: UITextField!
    @IBOutlet private weak var emailAdressTextField: UITextField!
    @IBOutlet private weak var telephoneNumberTextField: UITextField!
    @IBOutlet private weak var photoButton: UIButton!
    @IBOutlet private weak var imageView: UIImageView!
    
    // MARK: - IBActions
    
    @IBAction func imagePickerButton(sender: AnyObject) {
        let alert = UIAlertController(title: "Choose Image", message: nil, preferredStyle: .ActionSheet)
        let cameraAction = UIAlertAction(title: "Camera", style: .Default) { UIAlertAction in
            self.openCamera()
        }
        
        let galleryAction = UIAlertAction(title: "Gallery", style: .Default) { UIAlertAction in
            self.openGallery()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel) { UIAlertAction in
        }
        
        picker?.delegate = self
        
        alert.addAction(cameraAction)
        alert.addAction(galleryAction)
        alert.addAction(cancelAction)
        
        if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
            self.presentViewController(alert, animated: true, completion: nil)
            
        } else {
            popover = UIPopoverController(contentViewController: alert)
            popover!.presentPopoverFromRect(photoButton.frame, inView: self.view, permittedArrowDirections: UIPopoverArrowDirection.Any, animated: true)
        }
    }
    
    // MARK: - Private functions
    
    private func openCamera() {
        if UIImagePickerController.isSourceTypeAvailable(.Camera) {
            picker!.sourceType = .Camera
            presentViewController(picker!, animated: true, completion: nil)
            
        } else {
            openGallery()
        }
    }
    
    private func openGallery() {
        picker!.sourceType = .PhotoLibrary
        
        if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
            self.presentViewController(picker!, animated: true, completion: nil)
            
        } else {
            popover = UIPopoverController(contentViewController: picker!)
            popover!.presentPopoverFromRect(photoButton.frame, inView: self.view, permittedArrowDirections: UIPopoverArrowDirection.Any, animated: true)
        }
    }
    
    // MARK: - Override functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        picker!.delegate = self
    }
    
    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "saveSegue" {
            var data: NSData? = nil
            
            if let image = imageView.image {
                data = UIImagePNGRepresentation(image)
            }
            
            newContact = Contact(firstName: firstNameTextField.text!, lastName: lastNameTextField.text!, emailAdress: emailAdressTextField.text!, telephoneNumber: telephoneNumberTextField.text!, imageViewPath: "", imageData: data)
        }
    }
    
}

    // MARK: - Extension with UIImagePickerControllerDelegate, UINavigationControllerDelegate

extension AddContactViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String: AnyObject]) {
        picker.dismissViewControllerAnimated(true, completion: nil)
        imageView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
    }
    
}
