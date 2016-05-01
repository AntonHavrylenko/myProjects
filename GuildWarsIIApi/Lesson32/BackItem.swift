//
//  BackItem.swift
//  Lesson32
//
//  Created by Anton Havrylenko on 17.04.16.
//  Copyright © 2016 Havrylenko. All rights reserved.
//

import Foundation

final class BackItem {
    
    // MARK: - Properties
    
    var suffixItemId: NSNumber!
    var secondarySuffixItemId: String!
    
    // MARK: - Initializers
    
    init(_ dictionary: Dictionary<String, AnyObject>) {
        suffixItemId = dictionary["suffix_item_id"] as? NSNumber
        secondarySuffixItemId = dictionary["secondary_suffix_item_id"] as? String
    }
    
    // MARK: - Convenience functions
    
    func description() -> String {
        var description = ""
        
        if let suffixItemId = self.suffixItemId {
            description = "Suffix Item Id: " + suffixItemId.stringValue + "\n"
        }
        
        if let secondarySuffixItemId = self.secondarySuffixItemId where secondarySuffixItemId != ""  {
            description = description + "Secondary Suffix Item: " + secondarySuffixItemId + "\n"
        }
        
        return description
    }
    
}