//
//  FilmRepository.swift
//  Kino
//
//  Created by Julian Alonso on 7/12/15.
//  Copyright © 2015 Julian. All rights reserved.
//

import Foundation
import CoreData

final class FilmRepository: CoreDataRepository {
    typealias DataType = FilmMO
    
    let managedObjectContext: NSManagedObjectContext
    let writeManagedObjectContext: NSManagedObjectContext
    
    init(mainMOC: NSManagedObjectContext, backgroundMOC: NSManagedObjectContext) {
        self.managedObjectContext = mainMOC
        self.writeManagedObjectContext = backgroundMOC
    }
}