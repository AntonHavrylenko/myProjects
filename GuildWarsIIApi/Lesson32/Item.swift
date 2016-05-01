//
//  Item.swift
//  Lesson32
//
//  Created by Anton Havrylenko on 16.04.16.
//  Copyright © 2016 Havrylenko. All rights reserved.
//

import Foundation

final class Item {
    
    // MARK: - Properties
    
    var id: NSNumber!
    var chatLink: String!
    var name: String!
    var icon: String!
    var description: String!
    var rarity: String!
    var level: NSNumber!
    var vendorValue: NSNumber!
    var defaultSkin: NSNumber!
    var flags = [String]()
    var gameTypes = [String]()
    var restrictions = [String]()
    var type: String!
    var details: String!
    
    // MARK: - Initializers
    
     init(_ dictionary: Dictionary<String, AnyObject>) {
        id = dictionary["id"] as? NSNumber
        chatLink = dictionary["chat_link"] as? String
        name = dictionary["name"] as? String
        icon = dictionary["icon"] as? String
        description = dictionary["description"] as? String
        type = dictionary["type"] as? String
        rarity = dictionary["rarity"] as? String
        level = dictionary["level"] as? NSNumber
        vendorValue = dictionary["vendor_value"] as? NSNumber
        defaultSkin = dictionary["default_skin"] as? NSNumber
        flags = (dictionary["flags"] as? Array)!
        gameTypes = (dictionary["game_types"] as? Array)!
        restrictions = (dictionary["restrictions"] as? Array)!
        details = findInit(type, dictionary: dictionary["details"] as! Dictionary<String, AnyObject>)
    }
    
    // MARK: - Private functions
    
    private func findInit(type: String, dictionary: Dictionary<String, AnyObject>) -> String {
        switch type {
        case "Armor":
            return Armor(dictionary).description()
        case "Back":
            return BackItem(dictionary).description()
        case "Bag":
            return Bag(dictionary).description()
        case "Consumable":
            return Consumable(dictionary).infoDescription()
        case "Container":
            return Container(dictionary).description()
        case "Gathering":
            return GatheringTools(dictionary).description()
        case "Gizmo":
            return Gizmo(dictionary).description()
        case "MiniPet":
            return Miniature(dictionary).description()
        case "Tool":
            return SalvageKits(dictionary).description()
        case "Trinket":
            return Trinket(dictionary).description()
        case "UpgradeComponent":
            return UpgradeComponent(dictionary).description()
        case "Weapon":
            return Weapon(dictionary).description()
        default:
            break
        }
        
        return ""
    }
    
    // MARK: - Convenience functions
    
    func infoDescription() -> String {
        var ItemDescription = ""
        
        if let id = self.id {
            ItemDescription = ItemDescription + "Id: " + id.stringValue + "\n"
        }
        
        if let chatLink = self.chatLink where chatLink != "" {
            ItemDescription = ItemDescription + "Chat Link: " + chatLink + "\n"
        }
        
        if let name = self.name where name != "" {
            ItemDescription = ItemDescription + "Name: " + name + "\n"
        }
        
        if let description = self.description where description != "" {
            ItemDescription = ItemDescription + "Description: " + description + "\n"
        }
        
        if let type = self.type where type != "" {
            ItemDescription = ItemDescription + "Type: " + type + "\n"
        }
        
        if let rarity = self.rarity where rarity != "" {
            ItemDescription = ItemDescription + "Rarity: " + rarity + "\n"
        }
        
        if let level = self.level {
            ItemDescription = ItemDescription + "Level: " + level.stringValue + "\n"
        }
        
        if let vendorValue = self.vendorValue {
            ItemDescription = ItemDescription + "Vendor Value: " + vendorValue.stringValue + "\n"
        }
        
        if let defaultSkin = self.defaultSkin {
            ItemDescription = ItemDescription + "Default Skin: " + defaultSkin.stringValue + "\n"
        }
        
        for (index, value) in flags.enumerate() {
            if index == 0 {
                ItemDescription = ItemDescription + "Flags: " + value + ", "
            } else {
                ItemDescription = ItemDescription + value + ", "
            }
        }
        
        for (index, value) in gameTypes.enumerate() {
            if index == 0 {
                ItemDescription = ItemDescription + " \nGame Types: " + value + ", "
            } else {
                ItemDescription = ItemDescription + value + ", "
            }
        }
        
        for (index, value) in restrictions.enumerate() {
            if index == 0 {
                ItemDescription = ItemDescription + "\nRestrictions: " + value + ", "
            } else {
                ItemDescription = ItemDescription + value + ", "
            }
        }
        
        return ItemDescription
    }
    
}


