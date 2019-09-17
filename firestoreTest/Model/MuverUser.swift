//
//  MuverUser.swift
//  firestoreTest
//
//  Created by Edwin Lagos on 9/11/19.
//  Copyright © 2019 Edwin Lagos. All rights reserved.
//

import Foundation

class MuverUser
{
    let name: String!
    let ID: String!
    let availability: Bool!
    
    init(name: String, ID: String, availability: Bool) {
        self.name = name
        self.ID = ID
        self.availability = availability
    }
    
    init(data: Dictionary<String, Any>)
    {
        self.name = data[MuverConstants.db.MUVERUSER_NAME] as? String
        self.ID = data[MuverConstants.db.MUVERUSER_ID] as? String
        self.availability = data[MuverConstants.db.MUVERUSER_AVAILABILITY] as? Bool
    }
    
    func toDictionary() -> Dictionary<String, Any>{
        let newDict: Dictionary<String, Any> = [MuverConstants.db.MUVERUSER_NAME: self.name as Any,
                                                MuverConstants.db.MUVERUSER_ID: self.ID as Any,
                                                MuverConstants.db.MUVERUSER_AVAILABILITY: self.availability as Any]
        return newDict
    }
    
}
