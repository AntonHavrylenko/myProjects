//
//  Miniature.swift
//  Lesson32
//
//  Created by Anton Havrylenko on 17.04.16.
//  Copyright © 2016 Havrylenko. All rights reserved.
//

import Foundation

final class Miniature {
    
    // MARK: - Properties
    
    var minipetId: NSNumber!
    
    // MARK: - Initializers
    
    init(_ dictionary: Dictionary<String, AnyObject>) {
        minipetId = dictionary["minipet_id"] as? NSNumber
    }
    
    // MARK: - Convenience functions

    func description() -> String {
        return "Mini pet Id: " + minipetId.stringValue + "\n"
    }
    
}