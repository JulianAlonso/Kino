//
//  Parseable.swift
//  Kino
//
//  Created by Julian Alonso on 20/11/15.
//  Copyright © 2015 Julian. All rights reserved.
//

import Foundation

protocol Parseable {
    static func from(any: Any) throws -> Self
}

extension Parseable {
    
    static func date(stringDate: String, format: String) -> NSDate {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.dateFromString(stringDate)!
    }
    
}

enum ParseableError: ErrorType {
    case NotRecognizedType(String)
    case RequiredFieldsNotFound(String)
}