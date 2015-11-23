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
    var error: NSError?
    
    init(object: T?, error: NSError?) {
        self.object = object
        self.error = error
    }
    
    static func from(any: AnyObject) -> KinoResponse<T> {
        return self.init(object: (T.from(any) as! T), error: nil)
    }
    
    static func from(error: NSError) -> KinoResponse<T> {
        return self.init(object: nil, error: error)
    }
}