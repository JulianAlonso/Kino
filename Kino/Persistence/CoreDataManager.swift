//
//  CoreDataStack.swift
//  Kino
//
//  Created by Julian Alonso on 16/11/15.
//  Copyright © 2015 Julian. All rights reserved.
//

import Foundation
import CoreData

class CoreDataManager {
    
    private struct CoreDataVars {
        static let dataBaseName = "KinoDataBase.sqlite"
        static let modelName = "Kino"
    }
    
    // MARK: - SharedInstance
    static let sharedInstance = CoreDataManager()
    
    // MARK: - MOCs
    lazy var writerMOC: NSManagedObjectContext? = {
        let context = NSManagedObjectContext(concurrencyType: .PrivateQueueConcurrencyType)
        context.parentContext = self.readMOC
        context.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        return context
    }()
    
    lazy var readMOC: NSManagedObjectContext? = {
        let context = NSManagedObjectContext(concurrencyType: .MainQueueConcurrencyType)
        context.parentContext = self.diskWriterMOC
        context.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        return context
    }()
    
    lazy var diskWriterMOC: NSManagedObjectContext? = {
        let context = NSManagedObjectContext(concurrencyType: .PrivateQueueConcurrencyType)
        context.persistentStoreCoordinator = self.persistentStoreCoordinator
        context.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        return context
    }()
    
    // MARK: - Other Stuff
    lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = try! { [weak self] in //try! setted to test target, it gives an error when try! is removed. 😶
        var coordinator = NSPersistentStoreCoordinator(managedObjectModel: self!.managedObjectModel)
        let url = self!.applicationDocumentsDirectory.URLByAppendingPathComponent(CoreDataVars.dataBaseName)
        let options = [NSMigratePersistentStoresAutomaticallyOption: true, NSInferMappingModelAutomaticallyOption: true]
        do {
            try coordinator.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: url, options: options)
        } catch let error as NSError {
            DLog(error)
            
            do {
                try NSFileManager.defaultManager().removeItemAtURL(url)
            } catch let error as NSError {
                DLog(error)
            }
            coordinator = NSPersistentStoreCoordinator(managedObjectModel: self!.managedObjectModel)
            do {
                try coordinator.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: url, options: options)
            } catch let error as NSError {
                DLog(error)
            }
        }
        return coordinator
    }()
    
    lazy var managedObjectModel: NSManagedObjectModel = {
        let modelURL = NSBundle.mainBundle().URLForResource(CoreDataVars.modelName, withExtension: "momd")!
        return NSManagedObjectModel(contentsOfURL: modelURL)!
    }()
    
    lazy var managedObjectContext: NSManagedObjectContext = {
        let coordinator = self.persistentStoreCoordinator
        var managedObjectContext = NSManagedObjectContext(concurrencyType: .MainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = coordinator
        return managedObjectContext
    }()
    
    lazy var applicationDocumentsDirectory: NSURL = {
        return NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).last!
    }()
    
    // MARK: - Core Data Saving support
    func saveContext () {
        if managedObjectContext.hasChanges {
            do {
                try managedObjectContext.save()
            } catch {
                let nserror = error as NSError
                NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
                abort()
            }
        }
    }
    
    // MARK: - Inits
    private init () {
        self.registerNotifications()
    }
    
    // MARK: - Notifications
    private lazy var notificationCenter = {
        return NSNotificationCenter.defaultCenter()
    }()
    
    private func registerNotifications() {
        self.notificationCenter.addObserver(self, selector: #selector(CoreDataManager.didSaveNotification(_:)), name: NSManagedObjectContextDidSaveNotification, object: self.readMOC)
        self.notificationCenter.addObserver(self, selector: #selector(CoreDataManager.didSaveNotification(_:)), name: NSManagedObjectContextDidSaveNotification, object: self.writerMOC)
    }
    
    @objc func didSaveNotification(notification: NSNotification) {
        guard let notificationContext = notification.object as! NSManagedObjectContext?
        else {
            if self.writerMOC!.hasChanges {
                self.writerMOC!.performBlock({ [weak self] in
                    do {
                        try self!.writerMOC!.save()
                    } catch let error {
                        DLog(error)
                    }
                })
            }
            return
        }
        
        let updateContext = notificationContext == self.readMOC ? self.diskWriterMOC! : self.readMOC!
        if updateContext.hasChanges {
            updateContext.performBlock({
                do {
                    try updateContext.save()
                } catch let error {
                    DLog(error)
                }
            })
        }
    }
}