//
//  Opinion+CoreDataProperties.swift
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

extension Opinion {

    @NSManaged var likesHero: Bool
    @NSManaged var readed: Bool
    @NSManaged var date: NSDate?
    @NSManaged var note: String?
    @NSManaged var character: Character?

}
