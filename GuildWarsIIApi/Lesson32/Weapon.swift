//
//  Weapon.swift
//  Lesson32
//
//  Created by Anton Havrylenko on 17.04.16.
//  Copyright © 2016 Havrylenko. All rights reserved.
//

import Foundation

final class Weapon {
    
    // MARK: - Properties
    
    var type: String!
    var damageType: String!
    var minPower: NSNumber!
    var maxPower: NSNumber!
    var defence: NSNumber!
    var suffixItemId: NSNumber!
    var secondarySuffixItemId: String!
    
    // MARK: - Initializers
    
    init(_ dictionary: Dictionary<String, AnyObject>) {
        type = dictionary["type"] as? String
        damageType = dictionary["damage_type"] as? String
        minPower = dictionary["min_power"] as? NSNumber
        maxPower = dictionary["max_power"] as? NSNumber
        defence = dictionary["defense"] as? NSNumber
        suffixItemId = dictionary["suffix_item_id"] as? NSNumber
        secondarySuffixItemId = dictionary["secondary_suffix_item_id"] as? String
    }
    
    // MARK: - Convenience functions

    func description() -> String {
        var description = ""
        
        if let type = self.type where type != "" {
            description = "Type: " + type + "\n"
        }
        
        if let damageType = self.damageType where damageType != "" {
            description = description + "Damage Type: " + damageType + "\n"
        }
        
        if let minPower = self.minPower {
            description = description + "Min Power: " + minPower.stringValue + "\n"
        }
        
        if let maxPower = self.maxPower {
            description = description + "Max Power: " + maxPower.stringValue + "\n"
        }
        
        if let defence = self.defence {
            description = description + "Defence: " + defence.stringValue + "\n"
        }
        
        if let suffixItemId = self.suffixItemId where suffixItemId != "" {
            description = description + "Suffix Item Id: " + suffixItemId.stringValue + "\n"
        }
        
        if let secondarySuffixItemId = self.secondarySuffixItemId where secondarySuffixItemId != "" {
            description = description + "Secondary Suffix Item Id: " + secondarySuffixItemId + "\n"
        }
        
        return description
    }
    
}
