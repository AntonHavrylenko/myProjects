//
//  Character+CoreDataProperties.swift
//  Lesson34
//
//  Created by Anton Havrylenko on 25.04.16.
//  Copyright © 2016 Havrylenko. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Character {
  
    // if version 1 and 1.1
    @NSManaged var imageData: NSData?
    @NSManaged var infoDescription: String?
    @NSManaged var name: String?
    
    // all versions
    @NSManaged var id: Int64
    
    // if version 1.1 and 1.2
    @NSManaged var likes: Int64
    @NSManaged var createDate: NSDate?
    @NSManaged var modifiedDate: NSDate?
    @NSManaged var opinion: Opinion?
    @NSManaged var orderId: Int64
    @NSManaged var removed: Bool
    
    // if version 1.2
//    @NSManaged var characterName: String?
//    @NSManaged var data: NSData?
//    @NSManaged var characterDescription: String?
    
}
