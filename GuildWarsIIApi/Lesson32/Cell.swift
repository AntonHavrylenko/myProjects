//
//  Cell.swift
//  Lesson32
//
//  Created by Anton Havrylenko on 15.04.16.
//  Copyright © 2016 Havrylenko. All rights reserved.
//

import UIKit

final class Cell: UITableViewCell {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var cellImageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    
     // MARK: - Override functions
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.cellImageView.sd_cancelCurrentImageLoad()
        self.cellImageView.image = nil
        self.label.text = nil
    }
    
}
