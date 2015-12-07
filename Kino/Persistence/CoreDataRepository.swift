//
//  CoreDataRepository.swift
//  Kino
//
//  Created by Julian Alonso on 7/12/15.
//  Copyright © 2015 Julian. All rights reserved.
//

import Foundation
import CoreData

protocol CoreDataRepository: Repository {
    var managedObjectContext: NSManagedObjectContext { get }
    var writeManagedObjectContext: NSManagedObjectContext { get }
}

extension CoreDataRepository where DataType: KinoMO, DataType: CoreDataBuilder {
    
    func objectById(id: String, completion: (inner: () throws -> DataType?) -> Void) {
        self.objectById(id, managedObjectContext: self.managedObjectContext, completion: completion)
    }
    
    func createOrUpdateObject(object: DataType.RelationshipObjectType, completion: (inner: () throws -> DataType) -> Void) {
        self.createOrUpdateObject(object, save: true) { (inner) -> Void in
            completion(inner: inner)
        }
    }
    
    func createOrUpdateObjects(objects: [DataType.RelationshipObjectType], completion: (inner: () throws -> [DataType]) -> Void) {
    
        var updatedObjects = [DataType]()
        
        var count = 0
        for object in objects {
            self.createOrUpdateObject(object, save: false, completion: { (inner: () throws -> DataType) -> Void in
                do {
                    updatedObjects.append(try inner())
                } catch {
                    DLog("Error on create or update objets: \(error)")
                }
                count++
                if count == objects.count {
                    self.writeManagedObjectContext.performBlock({ () -> Void in
                        do {
                            try self.writeManagedObjectContext.save()
                            completion(inner: { return updatedObjects })
                        } catch {
                            completion(inner: { throw error })
                        }
                    })
                }
            })
        }
    }
    
    func deleteObject(object: DataType.RelationshipObjectType) {
        self.objectById(object.id, managedObjectContext: self.writeManagedObjectContext) { (inner) -> Void in
            do {
                let object = try inner()
                if let object = object {
                    self.writeManagedObjectContext.deleteObject(object)
                }
            } catch {
                DLog(error)
            }
        }
    }
    
    // MARK: - Private methods
    private func objectById(id: String, managedObjectContext: NSManagedObjectContext, completion: (inner: () throws -> DataType?) -> Void) {
        
        let fetchRequest = NSFetchRequest(entityName: "\(DataType.self)")
        fetchRequest.predicate = NSPredicate(format: "id == %@", id)
        
        do {
            let foundObject = try managedObjectContext.executeFetchRequest(fetchRequest).first as! DataType?
            completion(inner: { return foundObject })
        } catch {
            completion(inner: { throw error })
        }
    }
    
    private func createOrUpdateObject(object: DataType.RelationshipObjectType, save: Bool, completion: (inner: () throws -> DataType) -> Void) {
        self.writeManagedObjectContext.performBlock { () -> Void in
            self.objectById(object.id, managedObjectContext: self.writeManagedObjectContext) { (inner: () throws -> DataType?) -> Void in
                do {
                    var foundObject = try inner()
                    
                    if foundObject != nil {
                        foundObject?.merge(object)
                    } else {
                        foundObject = DataType.create(object, managedObjectContext: self.writeManagedObjectContext)
                    }
                    
                    if save {
                        try self.writeManagedObjectContext.save()
                    }
                } catch {
                    DLog(error)
                }
            }
        }
    }
    
}
