//
//  DetailViewController.swift
//  Lesson32
//
//  Created by Anton Havrylenko on 15.04.16.
//  Copyright © 2016 Havrylenko. All rights reserved.
//

import UIKit

final class DetailViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet private weak var infoLabel: UILabel!
    @IBOutlet private weak var detailLabel: UILabel!
    @IBOutlet private weak var imageView: UIImageView!
    
    // MARK: - Properties
    
    var item: Item!
    
    // MARK: - Override functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let item = self.item, url = NSURL(string: item.icon) {
            imageView.sd_setImageWithURL(url)
            detailLabel.text = item.infoDescription()
            infoLabel.text = item.details
        }
    }
    
}
