//
//  GeneralFunctions.swift
//  Kino
//
//  Created by Julian Alonso on 16/11/15.
//  Copyright © 2015 Julian. All rights reserved.
//

import Foundation

func DLog(message: Any) {
    #if DEBUG
    print(message)
    #endif
}

// MARK: - Locale functions
func currentCountryCode() -> String {
    return NSLocale.currentLocale().objectForKey(NSLocaleCountryCode) as! String
}

// MARK: - UserDefaults functions
class UserDefaults {
    
    class func write(key: String, _ object: AnyObject?, defaultObject: AnyObject? = nil) {
        var objectToSet = defaultObject
        if let object = object {
            objectToSet = object
        }
        NSUserDefaults.standardUserDefaults().setObject(objectToSet, forKey: key)
    }
    
    class func read(key: String, defaultObject: AnyObject? = nil) -> AnyObject? {
        var objectToReturn = defaultObject
        if let readedObject = NSUserDefaults.standardUserDefaults().objectForKey(key) {
            objectToReturn = readedObject
        }
        return objectToReturn
    }
    
}