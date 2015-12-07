//
//  CoreDataBuilder.swift
//  Kino
//
//  Created by Julian Alonso on 7/12/15.
//  Copyright © 2015 Julian. All rights reserved.
//

import Foundation
import CoreData

protocol CoreDataBuilder: PersistenceObject {
    static func create(object: RelationshipObjectType, managedObjectContext: NSManagedObjectContext) -> Self
    mutating func merge(object: RelationshipObjectType)
}

extension CoreDataBuilder {
    static func new(managedOjectContext: NSManagedObjectContext) -> Self {
        return NSEntityDescription.insertNewObjectForEntityForName("\(RelationshipObjectType.self)", inManagedObjectContext: managedOjectContext) as! Self
    }
}