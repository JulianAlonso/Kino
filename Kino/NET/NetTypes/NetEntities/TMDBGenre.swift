//
//  TMDBGenre.swift
//  Kino
//
//  Created by Julian Alonso on 1/12/15.
//  Copyright © 2015 Julian. All rights reserved.
//

import Foundation

struct TMDBGenre {
    
    let id: String
    let name: String
    
    init(id: String, name: String) {
        self.id = id
        self.name = name
    }
}

extension TMDBGenre: Parseable {
    
    static func from(any: Any) throws -> TMDBGenre {
        if let dictionary = any as? Dictionary<String, AnyObject> {
            return try TMDBGenre(dictionary: dictionary)
        }
        throw ParseableError.NotRecognizedType("Type \(any.dynamicType) not recognized.")
    }
    
    init(dictionary: Dictionary<String, AnyObject>) throws {

        guard
            let id = dictionary[Fields.ID] as? Int,
            let name = dictionary[Fields.Name] as? String
        else { throw ParseableError.RequiredFieldsNotFound("❌ \(dictionary) not has all the required fields.") }
        
        self.init(id: String(id), name: name)
    }
    
    private struct Fields {
        static let ID = "id"
        static let Name = "name"
    }
    
}