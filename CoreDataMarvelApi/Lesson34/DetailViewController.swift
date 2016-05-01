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
    
    var name = ""
    var infoDescription = ""
    var imageData = NSData()
    var id = NSNumber()
    
    // MARK: - IBOutlets
    
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var detailLabel: UILabel!
    @IBOutlet private weak var mainLabel: UILabel!
    
    // MARK: - Override functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.image = UIImage(data: imageData)
        detailLabel.text = infoDescription
        mainLabel.text = name + " (ID: " + String(id) + ")"
    }

}
