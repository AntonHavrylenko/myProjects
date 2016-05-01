//
//  Trinket.swift
//  Lesson32
//
//  Created by Anton Havrylenko on 17.04.16.
//  Copyright © 2016 Havrylenko. All rights reserved.
//

import Foundation

final class Trinket {
    
    // MARK: - Properties
    
    var type: String!
    var suffixItemId: NSNumber!
    var secondarySuffixItemId: String!
    
    // MARK: - Initializers
    
    init(_ dictionary: Dictionary<String, AnyObject>) {
        type = dictionary["type"] as? String
        suffixItemId = dictionary["suffix_item_id"] as? NSNumber
        secondarySuffixItemId = dictionary["secondary_suffix_item_id"] as? String
    }
    
    // MARK: - Convenience functions

    func description() -> String {
        var description = ""
        
        if let type = self.type where type != "" {
            description = "Type: " + type + "\n"
        }
        
        if let suffixItemId = self.suffixItemId {
            description = description + "Suffix Item Id: " + suffixItemId.stringValue + "\n"
        }
        
        if let secondarySuffixItemId = self.secondarySuffixItemId where secondarySuffixItemId != "" {
            description = description + "Secondary Suffix Item Id: " + secondarySuffixItemId + "\n"
        }
        
        return description
    }
    
}