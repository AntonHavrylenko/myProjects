//
//  Contact.swift
//  Lesson33
//
//  Created by Anton Havrylenko on 18.04.16.
//  Copyright © 2016 Havrylenko. All rights reserved.
//

import Foundation

class Contact: NSObject, NSCoding {
    
    // MARK: - Properties
    
    var firstName: String
    var lastName: String
    var emailAdress: String
    var telephoneNumber: String
    var imageViewPath: String
    var imageData: NSData?
    
    // MARK: - Initializers
    
    override init() {
        firstName = ""
        lastName = ""
        emailAdress = ""
        telephoneNumber = ""
        imageViewPath = ""
    }
    
    init(firstName: String, lastName: String, emailAdress: String, telephoneNumber: String, imageViewPath: String, imageData: NSData?) {
        self.firstName = firstName
        self.lastName = lastName
        self.emailAdress = emailAdress
        self.telephoneNumber = telephoneNumber
        self.imageViewPath = imageViewPath
        self.imageData = imageData
    }
    
    // MARK: - NSCoding Protocol
    
    required init?(coder aDecoder: NSCoder) {
        firstName = aDecoder.decodeObjectForKey("firstName") as! String
        lastName = aDecoder.decodeObjectForKey("lastName") as! String
        emailAdress = aDecoder.decodeObjectForKey("emailAdress") as! String
        telephoneNumber = aDecoder.decodeObjectForKey("telephoneNumber") as! String
        imageViewPath = aDecoder.decodeObjectForKey("imageViewPath") as! String
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(firstName, forKey: "firstName")
        aCoder.encodeObject(lastName, forKey: "lastName")
        aCoder.encodeObject(emailAdress, forKey: "emailAdress")
        aCoder.encodeObject(telephoneNumber, forKey: "telephoneNumber")
        aCoder.encodeObject(imageViewPath, forKey: "imageViewPath")
    }
    
}


