//
//  OpinionViewController.swift
//  Lesson34
//
//  Created by Anton Havrylenko on 25.04.16.
//  Copyright © 2016 Havrylenko. All rights reserved.
//

import UIKit

final class OpinionViewController: UIViewController {
    
    // MARK: - Properties
    
    var hero: Character!
    
    // MARK: - IBOutlets
    
    @IBOutlet private weak var noteTextView: UITextView!
    @IBOutlet private weak var dateTextView: UITextView!
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var likesTextField: UITextField!
    @IBOutlet private weak var readedTextField: UITextField!
    @IBOutlet private weak var editOrSaveButton: UIBarButtonItem!
    
    // MARK: - IBActions
    
    @IBAction func editOrSaveButtonAction(sender: AnyObject) {
        if editOrSaveButton.title == "Edit" {
            editOrSaveButton.title = "Save"
            likesTextField.userInteractionEnabled = true
            readedTextField.userInteractionEnabled = true
            noteTextView.userInteractionEnabled = true
            
        } else {
            editOrSaveButton.title = "Edit"
            saveNote(noteTextView.text!)
            saveLikes(likesTextField.text!)
            saveReaded(readedTextField.text!)
            likesTextField.userInteractionEnabled = false
            readedTextField.userInteractionEnabled = false
            noteTextView.userInteractionEnabled = false
            
            (UIApplication.sharedApplication().delegate as! AppDelegate).saveContext()
            
            self.navigationController?.popViewControllerAnimated(true)
        }
        
    }
    
    // MARK: - Override functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        readedTextField.delegate = self
        
        //if version 1.2
//        if let data = hero.data {
//            imageView.image = UIImage(data: data)
//        }
        
        // if version 1.1
        if let data = hero.imageData {
            imageView.image = UIImage(data: data)
        }
    
        if let hero = hero.opinion?.likesHero where hero {
            likesTextField.text = "Yes"
            
        } else {
            likesTextField.text = "No"
        }
    
        if let hero = hero.opinion?.readed where hero && self.hero.opinion?.date != nil {
            readedTextField.text = "Yes"
            hideTextView(false)
            let formatter = NSDateFormatter()
            formatter.dateFormat = "yyyy.MM.dd"
            dateTextView.text = formatter.stringFromDate(self.hero.opinion!.date!)
            
        } else {
            readedTextField.text = "No"
            hideTextView(true)
        }
        
        if hero.opinion?.note != "" {
            noteTextView.text = hero.opinion?.note
        }
    }
    
    // MARK: - Private functions
    
    private func hideTextView(status: Bool) {
        if status {
            UIView.animateWithDuration(0.5, animations: {
                self.dateTextView.alpha = 0
            })
            
        } else {
            UIView.animateWithDuration(0.5, animations: {
                self.dateTextView.alpha = 1
            })
        }
    }
    
    private func saveLikes(text: String) {
        // if version 1.1 and 1.2
        if text == "Yes" {
            hero.opinion?.likesHero = true
            
        } else if text == "No" {
            hero.opinion?.likesHero = false
            
        } else {
            hero.opinion?.likesHero = true
        }
    }
    
    private func saveReaded(text: String) {
       // if version 1.1 and 1.2
        if text == "Yes" && dateTextView.text != "" {
            hero.opinion?.readed = true
            saveDate(dateTextView.text!)
            
        } else if text == "No" {
            hero.opinion?.readed = false
            
        } else {
            hero.opinion?.readed = false
        }
    }
    
    private func saveNote(text: String) {
        // if version 1.1 and 1.2
        if text != "" {
            hero.opinion?.note = text
        }
    }
    
    private func saveDate(text: String) {
        // if version 1.1 and 1.2
        let formatter = NSDateFormatter()
        formatter.dateFormat = "yyyy.MM.dd"
        hero.opinion?.date = formatter.dateFromString(text)
    }
    
}

// MARK: - Extension with UITextFieldDelegate

extension OpinionViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(textField: UITextField) {
        if textField.text?.lowercaseString == "Yes".lowercaseString {
            hideTextView(false)
            dateTextView.userInteractionEnabled = true
            
        } else {
            hideTextView(true)
        }
    }
    
}

// MARK: - Extension with UITextViewDelegate

extension OpinionViewController: UITextViewDelegate {
    
    func textViewDidBeginEditing(textView: UITextView) {
        let text1 = "If 'Yes'- Please, Enter the date "
        let text2 = "You may write something about him."
        
        if textView.text == text1 || textView.text == text2 {
            textView.text = ""
        }
    }
    
}
