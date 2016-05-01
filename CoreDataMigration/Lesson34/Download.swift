//
//  Download.swift
//  Lesson34
//
//  Created by Anton Havrylenko on 27.04.16.
//  Copyright © 2016 Havrylenko. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import CoreData

final class Download {
    
    // MARK: - Properties
    
    private let url = "http://gateway.marvel.com:80/v1/public/characters"
    private var managedContext: NSManagedObjectContext = {
        return (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    }()
    private var orderId = 0
    
    // MARK: - Convenience functions
    
    func getItemsURLs() {
        Alamofire.request(.GET, url, parameters: getParameters()).responseJSON { response in
            guard let object = response.result.value else {
                return
            }
            
            let json = JSON(object)
            
            for (_, value) in json["data"]["results"] {
                let id = value["id"]
                
                let url = "http://gateway.marvel.com:80/v1/public/characters/\(id)"
                
                Alamofire.request(.GET, url, parameters: self.getParameters()).responseJSON { response in
                    guard let object = response.result.value else {
                        return
                    }
                    
                    let json = JSON(object)
                    
                    dispatch_async(dispatch_get_global_queue(QOS_CLASS_DEFAULT, 0)) {
                        let character = Hero(json: json)
                        
                        dispatch_async(dispatch_get_main_queue(), {
                            self.saveCharacter(character)
                        })
                    }
                }
            }
        }
    }
    
    // MARK: - Private functions
    
    private func saveCharacter(hero: Hero) {
        let allCharacters = managedContext.registeredObjects
        let consisted = allCharacters.contains { (character) -> Bool in
            if character.isKindOfClass(Character) {
                
                // if version 1 and 1.1
                return (character as! Character).name == hero.name
                
                // if version 1.2
//                return (character as! Character).characterName == hero.name
            }
            
            return false
        }
        
        if !consisted {
            let entity = NSEntityDescription.entityForName("Character", inManagedObjectContext: managedContext)
            let tempCharacter = Character(entity: entity!, insertIntoManagedObjectContext: managedContext)
            
            // if version 1.2
//                        tempCharacter.characterName = hero.name
//                        tempCharacter.data = hero.imageData
//                        tempCharacter.characterDescription = hero.description
            
            // if version 1 and 1.1
            tempCharacter.name = hero.name
            tempCharacter.imageData = hero.imageData
            tempCharacter.infoDescription = hero.description
            
            // all versions
            tempCharacter.id = hero.id
            
            // if version 1.1 and 1.2
            tempCharacter.likes = Int64(arc4random()%10000)
            tempCharacter.createDate = NSDate()
            tempCharacter.modifiedDate = NSDate()
            tempCharacter.opinion = createDefaultOpinion()
            tempCharacter.orderId = Int64(orderId)
            tempCharacter.removed = false
            
            (UIApplication.sharedApplication().delegate as! AppDelegate).saveContext()
            orderId += 1
        }
    }
    
    private func createDefaultOpinion() -> Opinion {
        let entity = NSEntityDescription.entityForName("Opinion", inManagedObjectContext: managedContext)
        let tempOpinion = Opinion(entity: entity!, insertIntoManagedObjectContext: managedContext)
        tempOpinion.note = String()
        tempOpinion.likesHero = true
        tempOpinion.readed = false
        
        return tempOpinion
    }
    
    private func getParameters() -> Dictionary <String, AnyObject> {
        let publicKey = "47654b6646da81eed4633f939180d136"
        let privateKey = "ec1276030b6609939ec844b40277481e60700313"
        let formatter = NSDateFormatter()
        formatter.dateFormat = "yyyyMMddHHmmss"
        let timeStamp = formatter.stringFromDate(NSDate())
        let hash = "\(timeStamp)\(privateKey)\(publicKey)".md5()
        let parameters = ["apikey": publicKey, "ts": timeStamp, "hash": hash]
        
        return parameters
    }
    
}