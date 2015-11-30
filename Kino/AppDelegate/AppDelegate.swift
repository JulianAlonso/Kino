//
//  AppDelegate.swift
//  Kino
//
//  Created by Julian Alonso on 16/11/15.
//  Copyright © 2015 Julian. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    lazy var coreDataStack : CoreDataStack = {
        return CoreDataStack()
    }()
    
    lazy var mainRouter: MainRouter = {
        return MainRouter()
    }()

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        self.window = UIWindow.init(frame: UIScreen.mainScreen().bounds)
        self.mainRouter.showMainViewInWindow(self.window!)
        return true
    }

    func applicationWillTerminate(application: UIApplication) {
        do {
            try self.coreDataStack.managedObjectContext.save()
        } catch {
            
        }
    }

}

