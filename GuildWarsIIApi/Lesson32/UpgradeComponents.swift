//
//  UpgradeComponents.swift
//  Lesson32
//
//  Created by Anton Havrylenko on 17.04.16.
//  Copyright © 2016 Havrylenko. All rights reserved.
//

import Foundation

final class UpgradeComponent {
    
    // MARK: - Properties
    
    var type: String!
    var flags = [String]()
    var infusionUpgradeFlags = [String]()
    var suffix: String!
    var bonuses: String!
    
    // MARK: - Initializers
    
    init(_ dictionary: Dictionary<String, AnyObject>) {
        type = dictionary["type"] as? String
        flags = (dictionary["flags"] as? [String])!
        infusionUpgradeFlags = (dictionary["infusion_upgrade_flags"] as? [String])!
        suffix = dictionary["suffix"] as? String
        bonuses = dictionary["bonuses"] as? String
    }
    
    // MARK: - Convenience functions

    func description() -> String {
        var description = ""
        
        if let type = self.type where type != "" {
            description = type + "\n"
        }
        
        for (index, value) in flags.enumerate() {
            if index == 0 {
                description = description + "Flags: " + value + ", "
            } else {
                description = description + value + ", "
            }
        }
        
        for (index, value) in infusionUpgradeFlags.enumerate() {
            if index == 0 {
                description = description + "Infusion Upgrade Flags: " + value + ", "
            } else {
                description = description + value + ", "
            }
        }
        
        if let suffix = self.suffix where suffix != "" {
            description = description + "Suffix: " + suffix + "\n"
        }
        
        if let bonuses = self.bonuses where bonuses != "" {
            description = description + "Bonuses: " + bonuses + "\n"
        }
        
        return description
    }
    
}