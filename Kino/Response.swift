//
//  Response.swift
//  Kino
//
//  Created by Julian Alonso on 20/11/15.
//  Copyright © 2015 Julian. All rights reserved.
//

import Foundation

protocol Response {
    
    var error: NSError? { get set }
    
    static func from(any: AnyObject) -> Self
    static func from(error: NSError) -> Self
}