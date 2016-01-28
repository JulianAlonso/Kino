//
//  FilmReleasesResponse.swift
//  Kino
//
//  Created by Julian Alonso on 1/12/15.
//  Copyright © 2015 Julian. All rights reserved.
//

import Foundation

struct FilmReleasesResponse {
    
    let releaseDates: [TMDBFilmRelease]
    
    init(releaseDates: [TMDBFilmRelease]) {
        self.releaseDates = releaseDates
    }
}

extension FilmReleasesResponse: Response {
    
    // MARK: - Paseable
    static func from(any: Any) throws -> FilmReleasesResponse {
        if let dictionary = any as? Dictionary<String, AnyObject> {
            return try FilmReleasesResponse(dictionary: dictionary)
        }
        throw ParseableError.NotRecognizedType("Type \(any.dynamicType) not recognized.")
    }
    
    init(dictionary: Dictionary<String, AnyObject>) throws {
        
        guard
            let releases = dictionary[Fields.Releases] as? [Dictionary<String, AnyObject>]
        else { throw ParseableError.RequiredFieldsNotFound("❌ Required fields not found at \(dictionary)") }
        
        let releaseDates = releases.flatMap { (dictionary) -> TMDBFilmRelease? in
            do {
                return try TMDBFilmRelease(dictionary: dictionary)
            } catch let error {
                DLog(error)
            }
            return nil
        }
        
        self.releaseDates = releaseDates
    }

    private struct Fields {
        static let Releases = "countries"
    }
}