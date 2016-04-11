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
        filmMO.originalTitle = object.originalTitle
        filmMO.backdropPath = object.backdropPath
        //homepage not done
        filmMO.overview = object.overview
        filmMO.posterPath = object.posterPath
        filmMO.runtime = object.runtime
        filmMO.voteAverage = object.voteAverage
        filmMO.votes = object.voteCount
        
        if let genres = object.genres {
            let genremos = genres.map({ GenreMO.create($0, managedObjectContext: managedObjectContext) })
            filmMO.filmGenres = NSOrderedSet(array: genremos)
        }
        if let releaseDates = object.releaseDates {
            let dates = releaseDates.map({ FilmReleaseMO.create($0, managedObjectContext: managedObjectContext) })
            filmMO.filmReleases = NSSet(array: dates)
        }
        
        return filmMO
    }
    
    func merge(object: RelationshipObjectType) {
        
        self.title = object.title
        self.originalTitle = object.originalTitle
        self.backdropPath = object.backdropPath
        //homepage not done
        self.overview = object.overview
        self.posterPath = object.posterPath
        self.runtime = object.runtime
        self.voteAverage = object.voteAverage
        self.votes = object.voteCount
        
        if let genres = object.genres {
            self.filmGenres = NSOrderedSet(array: genres.map({ GenreMO.create($0, managedObjectContext: self.managedObjectContext!) }))
        }
        if let releaseDates = object.releaseDates {
            self.filmReleases = NSSet(array: (releaseDates.map({ FilmReleaseMO.create($0, managedObjectContext: self.managedObjectContext!) })))
        }
    }

}
