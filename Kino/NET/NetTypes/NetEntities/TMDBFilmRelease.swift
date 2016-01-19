//
//  TMDBFilmRelease.swift
//  Kino
//
//  Created by Julian Alonso on 1/12/15.
//  Copyright © 2015 Julian. All rights reserved.
//

import Foundation

struct TMDBFilmRelease {
    
    let certification: String
    let countryISO: String
    let releaseDate: NSDate
    
    init(certification: String, countryISO: String, releaseDate: NSDate) {
        self.certification = certification
        self.countryISO = countryISO
        self.releaseDate = releaseDate
    }
    
}

extension TMDBFilmRelease: Parseable {
    
    static func from(any: Any) throws -> TMDBFilmRelease {
        if let dictionary = any as? Dictionary<String, AnyObject> {
            return try TMDBFilmRelease(dictionary: dictionary)
        }
        throw ParseableError.NotRecognizedType("Type \(any.dynamicType) not recognized.")
    }
    
    init(dictionary: Dictionary<String, AnyObject>) throws {
        DLog(dictionary)
        guard
            let certification = dictionary[Fields.Ceritification] as? String,
            let countryISO = dictionary[Fields.CountryISO] as? String,
            let releaseDate = dictionary[Fields.ReleaseDate] as? String
        else { throw ParseableError.RequiredFieldsNotFound("❌ \(dictionary) not has all the required fields.") }
        
        self.init(certification: certification, countryISO: countryISO, releaseDate: TMDBFilmRelease.date(releaseDate, format: Config[TMDBFormats.DateFormat] as! String))
    }
    
    private struct Fields {
        static let Ceritification = "certification"
        static let CountryISO = "iso_3166_1"
        static let ReleaseDate = "release_date"
    }
}