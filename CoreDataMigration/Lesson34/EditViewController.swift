//
//  EditViewController.swift
//  Lesson34
//
//  Created by Anton Havrylenko on 28.04.16.
//  Copyright © 2016 Havrylenko. All rights reserved.
//

import UIKit

final class EditViewController: UIViewController {

    // MARK: - Properties
    
    var hero: Character!
    
    // MARK: - IBOutlets
 
    @IBOutlet private weak var nameTextField: UITextField!
    @IBOutlet private weak var idTextField: UITextField!
    @IBOutlet private weak var orderIDTextField: UITextField!
    @IBOutlet private weak var likesTextField: UITextField!
    @IBOutlet private weak var descriptionTextView: UITextView!
    
    // MARK: - IBActions
    
    @IBAction func save(sender: AnyObject) {
        if let hero = self.hero {
            // if version 1.2
//           hero.characterName = nameTextField.text
//           hero.characterDescription = descriptionTextView.text
            
            // if version 1 and 1.1
            hero.name = nameTextField.text
            hero.infoDescription = descriptionTextView.text
            
            // if 1.1 and 1.2
            if let idText = idTextField.text, id = Int64(idText) {
                hero.id = id
            }
            
            if let orderIDText = orderIDTextField.text, orderiD = Int64(orderIDText) {
                hero.orderId = orderiD
            }
            
            if let likesText = likesTextField.text, likes = Int64(likesText) {
                hero.likes = likes
            }
            
            hero.modifiedDate = NSDate()
        }
        
        (UIApplication.sharedApplication().delegate as! AppDelegate).saveContext()
        navigationController?.popViewControllerAnimated(true)
    }
    
    // MARK: - Override functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let hero = self.hero {
            // if version 1.2
//            nameTextField.text = hero.characterName
//            descriptionTextView.text = hero.characterDescription
            
            // if version 1 and 1.1
            nameTextField.text = hero.name
            descriptionTextView.text = hero.infoDescription
            
            // if 1.1 and 1.2
            idTextField.text = String(hero.id)
            likesTextField.text = String(hero.likes)
            orderIDTextField.text = String(hero.orderId)
        }
    }

}
