//
//  Consumable.swift
//  Lesson32
//
//  Created by Anton Havrylenko on 17.04.16.
//  Copyright © 2016 Havrylenko. All rights reserved.
//

import Foundation

final class Consumable {
    
    // MARK: - Properties
    
    var type: String!
    var description: String!
    var durationMs: NSNumber!
    var unlockType:String!
    var colorId: NSNumber!
    var recipeId: NSNumber!
    
    // MARK: - Initializers
    
    init(_ dictionary: Dictionary<String, AnyObject>) {
        type = dictionary["type"] as? String
        description = dictionary["description"] as? String
        durationMs = dictionary["duration_ms"] as? NSNumber
        unlockType = dictionary["unlock_type"] as? String
        colorId = dictionary["color_id"] as? NSNumber
        recipeId = dictionary["recipe_id"] as? NSNumber
    }
    
    // MARK: - Convenience functions

    func infoDescription() -> String {
        var description = ""
        
        if let type = self.type {
            description = "Type: " + type + "\n"
        }
        
        if let infDescription = self.description where description != "" {
            description = description + "Description: " + infDescription + "\n"
        }
        
        if let durationMs = self.durationMs {
            description = description + "Duration Ms: " + durationMs.stringValue + "\n"
        }
        
        if let unlockType = self.unlockType where unlockType != "" {
            description = description + "Unlock Type: " + unlockType + "\n"
        }
        
        if let colorId = self.colorId {
            description = description + "Color Id: " + colorId.stringValue + "\n"
        }
        
        if let recipeId = self.recipeId {
            description = description + "Recipe Id: " + recipeId.stringValue + "\n"
        }
        
        return description
    }
    
}