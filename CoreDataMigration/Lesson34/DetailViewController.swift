//
//  DetailViewController.swift
//  Lesson34
//
//  Created by Anton Havrylenko on 23.04.16.
//  Copyright © 2016 Havrylenko. All rights reserved.
//

import UIKit

final class DetailViewController: UIViewController {
    
    // MARK: - Properties
    
    var hero: Character!
    
    // MARK: - IBOutlets
    
    @IBOutlet private weak var textView: UITextView!
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var detailLabel: UILabel!
    @IBOutlet private weak var mainLabel: UILabel!
    @IBOutlet private weak var yourOpinionButton: UIBarButtonItem!
    
    // MARK: - Override functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // if version1
//        yourOpinionButton.tintColor = UIColor.clearColor()
//        yourOpinionButton.enabled = false
        
        if let hero = self.hero {
            // if version 1.2
//            if let data = hero.data {
//                imageView.image = UIImage(data: data)
//            }

//           detailLabel.text = hero.characterDescription
//           mainLabel.text = hero.characterName! + " (ID: " + String(hero.id) + ")"
            
            // if version 1 and 1.1
            if let data = hero.imageData {
                imageView.image = UIImage(data: data)
            }
            
            detailLabel.text = hero.infoDescription
            mainLabel.text = hero.name! + " (ID: " + String(hero.id) + ")"
            
            // if version 1.1 and 1.2
            let formatter = NSDateFormatter()
            formatter.dateFormat = "yy. MM. dd"
            let create = formatter.stringFromDate(hero.createDate!)
            let modified = formatter.stringFromDate(hero.modifiedDate!)
            textView.text = String(format: "Create Date: %@ \n Modified Date:      %@ \n Likes: %li \n Order ID: %li \n", create, modified, hero.likes, hero.orderId)
        }
    }
    
    // if version 1.1 and 1.2
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let identifier = segue.identifier, opinionViewController = segue.destinationViewController as? OpinionViewController {
            
            if identifier == "Opinion" {
                opinionViewController.hero = hero
            }
        }
    }
    
}
