//
//  GenreMO+CoreDataProperties.swift
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

extension GenreMO {

    @NSManaged var name: String?
    @NSManaged var genreFilms: NSOrderedSet?

}
