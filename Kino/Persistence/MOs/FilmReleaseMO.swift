//
//  FilmReleaseMO.swift
//  Kino
//
//  Created by Julian Alonso on 11/4/16.
//  Copyright © 2016 Julian. All rights reserved.
//

import Foundation
import CoreData

extension TMDBFilmRelease: DomainObject {
    
    var id: String {
        get {
            return "id"
        }
    }
    
}

final class FilmReleaseMO: KinoMO {
    
}

extension FilmReleaseMO: CoreDataBuilder {
    
    typealias RelationshipObjectType = TMDBFilmRelease
    
    static func create(object: RelationshipObjectType, managedObjectContext: NSManagedObjectContext) -> FilmReleaseMO {
        
        let releaseMO = FilmReleaseMO.new(managedObjectContext)
        releaseMO.id = object.id
        releaseMO.certification = object.certification
        releaseMO.countryISO = object.countryISO
        releaseMO.releaseDate = object.releaseDate
        
        return releaseMO
    }
    
    func merge(object: RelationshipObjectType) {
        
        self.certification = object.certification
        self.countryISO = object.countryISO
        self.releaseDate = object.releaseDate
        
    }
    
}
