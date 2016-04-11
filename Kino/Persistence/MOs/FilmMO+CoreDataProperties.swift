//
//  FilmMO+CoreDataProperties.swift
//  Kino
//
//  Created by Julian Alonso on 11/4/16.
//  Copyright © 2016 Julian. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension FilmMO {

    @NSManaged var backdropPath: String?
    @NSManaged var homepage: String?
    @NSManaged var originalTitle: String?
    @NSManaged var overview: String?
    @NSManaged var posterPath: String?
    @NSManaged var releaseDate: NSDate?
    @NSManaged var runtime: NSNumber?
    @NSManaged var tagline: String?
    @NSManaged var title: String?
    @NSManaged var type: String?
    @NSManaged var voteAverage: NSNumber?
    @NSManaged var votes: NSNumber?
    @NSManaged var filmGenres: NSOrderedSet?
    @NSManaged var filmLists: NSSet?
    @NSManaged var filmReleases: NSSet?

}
