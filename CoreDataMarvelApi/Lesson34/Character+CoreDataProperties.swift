//
//  Character+CoreDataProperties.swift
//  Lesson34
//
//  Created by Anton Havrylenko on 24.04.16.
//  Copyright © 2016 Havrylenko. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Character {

    @NSManaged var id: NSNumber?
    @NSManaged var imageData: NSData?
    @NSManaged var infoDescription: String?
    @NSManaged var name: String?

}
