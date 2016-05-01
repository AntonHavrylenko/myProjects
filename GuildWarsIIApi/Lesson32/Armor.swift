//
//  Armor.swift
//  Lesson32
//
//  Created by Anton Havrylenko on 17.04.16.
//  Copyright © 2016 Havrylenko. All rights reserved.
//

import Foundation

final class Armor {
    
    // MARK: - Properties
    
    var type: String!
    var weightClass: String!
    var defence: NSNumber!
    var suffixItemId: NSNumber!
    var secondarySuffixItemId: String!
    
    // MARK: - Initializers
    
    init(_ dictionary: Dictionary<String, AnyObject>) {
        type = dictionary["type"] as? String
        weightClass = dictionary["weight_class"] as? String
        defence = dictionary["defence"] as? NSNumber
        suffixItemId = dictionary["suffix_item_id"] as? NSNumber
        secondarySuffixItemId = dictionary["secondary_suffix_item_id"] as? String
    }
    
    // MARK: - Convenience functions
    
    func description() -> String {
        var description = ""
        
        if let type = self.type {
            description = "Type: " + type + "\n"
        }
        
        if let weightClass = self.weightClass where weightClass != "" {
            description = description + "Weight Class: " + weightClass + "\n"
        }
        
        if let defence = self.defence {
            description = description + "Defence: " + defence.stringValue + "\n"
        }
        
        if let suffixItemId = self.suffixItemId {
            description = description + "Suffix Item Id: " + suffixItemId.stringValue + "\n"
        }
        
        if let secondarySuffixItemId = self.secondarySuffixItemId where secondarySuffixItemId != "" {
            description = description + "Secondary Suffix Item: " + secondarySuffixItemId + "\n"
        }
        
        return description
    }
    
}