//
//  GatheringTools.swift
//  Lesson32
//
//  Created by Anton Havrylenko on 17.04.16.
//  Copyright © 2016 Havrylenko. All rights reserved.
//

import Foundation

final class GatheringTools {
    
    // MARK: - Properties
    
    var type: String!
    
    // MARK: - Initializers
    
    init(_ dictionary: Dictionary<String, AnyObject>) {
        type = dictionary["type"] as? String
    }
    
    // MARK: - Convenience functions

    func description() -> String {
        return "Type: " + type + "\n"
    }
    
}