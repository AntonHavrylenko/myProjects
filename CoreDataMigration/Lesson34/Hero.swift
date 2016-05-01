//
//  Character.swift
//  Lesson34
//
//  Created by Anton Havrylenko on 22.04.16.
//  Copyright © 2016 Havrylenko. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON
import CoreData

final class Hero {
    
    // MARK: - Properties
    
    let id: Int64
    let name: String
    let description: String
    let imageData: NSData
    
    // MARK: - Initializers
    
    init(json: JSON) {
        self.id = json["data"]["results"][0]["id"].int64Value
        self.name = json["data"]["results"][0]["name"].stringValue
        self.description = json["data"]["results"][0]["description"].stringValue
        self.imageData = Hero.createDataForImage(json)
    }

    // MARK: - Private functions
    
    private class func createDataForImage(json: JSON) -> NSData {
        let path = json["data"]["results"][0]["thumbnail"]["path"].stringValue
        let imageExtension = json["data"]["results"][0]["thumbnail"]["extension"].stringValue
        let url = NSURL(string: path + "." + imageExtension)
        let data = NSData(contentsOfURL: url!)
        
        return data!
    }
    
}