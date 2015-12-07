//
//  PersistenceObject.swift
//  Kino
//
//  Created by Julian Alonso on 7/12/15.
//  Copyright © 2015 Julian. All rights reserved.
//

import Foundation

protocol PersistenceObject {
    // The persistence object must have a id property.
    // We use RelationshipObjectType to relate the domain object type with the persitence object type
    typealias RelationshipObjectType: DomainObject
}