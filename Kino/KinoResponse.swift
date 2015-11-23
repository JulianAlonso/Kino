//
//  BaseResponse.swift
//  Kino
//
//  Created by Julian Alonso on 20/11/15.
//  Copyright © 2015 Julian. All rights reserved.
//

import Foundation

struct KinoResponse<T: Parseable> : Response {
    
    var object: T?
    var objects: [T]?
    var error: NSError?
    
    init(object: T?, error: NSError?) {
        self.object = object
        self.error = error
    }
    
    init(objects: [T]?, error: NSError?) {
        self.objects = objects
        self.error = error
    }
    
    static func from(any: AnyObject) -> KinoResponse<T> {
        if any is [Dictionary<String, AnyObject>] {
            return self.init(objects: self.fromArray(any as! Array<Dictionary<String, AnyObject>>), error: nil)
        }
        else if any is Dictionary<String, AnyObject> {
            let parsed = T.from(dictionary: any as! Dictionary<String, AnyObject>)
            return self.init(object: parsed.object, error: parsed.error)
        }
        else {
            return self.init(object: nil, error: NSError(domain: "KinoResponse", code: -50, userInfo: [NSLocalizedDescriptionKey : "Error"]))
        }
    }
    
    static func from(error: NSError) -> KinoResponse<T> {
        return self.init(object: nil, error: error)
    }
    
    private static func fromArray(array: Array<Dictionary<String, AnyObject>>) -> [T] {
        var objects = Array<T>()
        for dictionary in array {
            let parsed = T.from(dictionary: dictionary)
            if let object = parsed.object {
                objects.append(object)
            }
        }
        return objects
    }
}