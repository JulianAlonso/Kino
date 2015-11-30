//
//  Film.swift
//  Kino
//
//  Created by Julian Alonso on 20/11/15.
//  Copyright © 2015 Julian. All rights reserved.
//

import Foundation

struct Film: Parseable {
    
    static func from(any: Any) throws -> Film {
        return(Film())
    }
    
}