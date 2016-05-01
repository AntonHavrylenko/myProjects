//
//  SalvageKits.swift
//  Lesson32
//
//  Created by Anton Havrylenko on 17.04.16.
//  Copyright © 2016 Havrylenko. All rights reserved.
//

import Foundation

final class SalvageKits {
    
    // MARK: - Properties
    
    var type: String!
    var charges: NSNumber!
    
    // MARK: - Initializers
    
    init(_ dictionary: Dictionary<String, AnyObject>) {
        type = dictionary["type"] as? String
        charges = dictionary["charges"] as? NSNumber
    }
    
    // MARK: - Convenience functions
    
    func description() -> String {
        var description = ""
        
        if let type = self.type where type != "" {
            description = "Types: " + type + "\n"
        }
        
        if let charges = self.charges {
            description = description + "Charges: " + charges.stringValue + "\n"
        }
        
        return description
    }
    
}