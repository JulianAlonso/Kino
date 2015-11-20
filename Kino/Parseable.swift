//
//  Parseable.swift
//  Kino
//
//  Created by Julian Alonso on 20/11/15.
//  Copyright © 2015 Julian. All rights reserved.
//

import Foundation

protocol Parseable {
    static func from(oject: AnyObject) -> (object: Self?, error: NSError?)
}