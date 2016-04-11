//
//  GenreMO.swift
//  Kino
//
//  Created by Julian Alonso on 11/4/16.
//  Copyright © 2016 Julian. All rights reserved.
//

import Foundation
import CoreData

extension TMDBGenre: DomainObject {
    
}

final class GenreMO: KinoMO {

}

extension GenreMO: CoreDataBuilder {
    
    typealias RelationshipObjectType = TMDBGenre
    
    static func create(object: RelationshipObjectType, managedObjectContext: NSManagedObjectContext) -> GenreMO {
        
        let genreMO = GenreMO.new(managedObjectContext)
        
        genreMO.id = object.id
        genreMO.name = object.name
        
        return genreMO
    }
    
    func merge(object: RelationshipObjectType) {
        self.name = object.name
    }
}
