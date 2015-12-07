//
//  Repository.swift
//  Kino
//
//  Created by Julian Alonso on 7/12/15.
//  Copyright © 2015 Julian. All rights reserved.
//

import Foundation

protocol Repository {
    typealias DataType: PersistenceObject
    
    func objectById(id: String, completion: (inner: () throws -> DataType?) -> Void)
    func createOrUpdateObject(object: DataType.RelationshipObjectType, completion: (inner: () throws -> DataType) -> Void)
    func createOrUpdateObjects(objects: [DataType.RelationshipObjectType], completion: (inner: () throws -> [DataType]) -> Void)
    func deleteObject(object: DataType.RelationshipObjectType)
}