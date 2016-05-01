//
//  Bag.swift
//  Lesson32
//
//  Created by Anton Havrylenko on 17.04.16.
//  Copyright © 2016 Havrylenko. All rights reserved.
//

import Foundation

final class Bag {
    
    // MARK: - Properties
    
    var size: NSNumber!
    var noSellOrSort: Bool!
    
    // MARK: - Initializers
    
    init(_ dictionary: Dictionary<String, AnyObject>) {
        size = dictionary["size"] as? NSNumber
        noSellOrSort = dictionary["no_sell_or_sort"] as? Bool
    }
    
    // MARK: - Convenience functions

    func description() -> String {
        var description = ""
        
        if let size = self.size {
            description = "Size: " + size.stringValue + "\n"
        }
        
        if let noSeelOrSort = self.noSellOrSort {
            description = description + "No Sell or Sort: " + noSeelOrSort.description + "\n"
        }
        
        return description
    }
    
}