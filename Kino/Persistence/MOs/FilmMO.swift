//
//  FilmMO.swift
//  Kino
//
//  Created by Julian Alonso on 7/12/15.
//  Copyright © 2015 Julian. All rights reserved.
//

import Foundation
import CoreData

extension TMDBFilm: DomainObject {
    
}

final class FilmMO: KinoMO, CoreDataBuilder {

    typealias RelationshipObjectType = TMDBFilm
    
    static func create(object: RelationshipObjectType, managedObjectContext: NSManagedObjectContext) -> FilmMO {
        
        let filmMO = FilmMO.new(managedObjectContext)
        
        filmMO.id = object.id
        filmMO.title = object.title
        
        
        return filmMO
    }
    
    func merge(object: RelationshipObjectType) {
        
    }

}
