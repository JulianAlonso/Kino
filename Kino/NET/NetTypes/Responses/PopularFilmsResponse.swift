//
//  PopularFilmsResponse.swift
//  Kino
//
//  Created by Julian Alonso on 24/11/15.
//  Copyright © 2015 Julian. All rights reserved.
//

import Foundation

struct PopularFilmsResponse {

    let page: Int
    let films: [TMDBFilm]
    
    init(page: Int, films: [TMDBFilm]) {
        self.page = page
        self.films = films
    }
    
}

extension PopularFilmsResponse: Response {
    // MARK: - Parseable
    static func from(any: Any) throws -> PopularFilmsResponse {
        
        let dictionary = any as! Dictionary<String, AnyObject>
        
        guard
            let page = dictionary[PopularFilmsResponseFields.Page] as? Int,
            let results = dictionary[PopularFilmsResponseFields.Results] as? [Dictionary<String, AnyObject>]
            else { throw ParseableError.RequiredFieldsNotFound("❌ Required fields not found at \(dictionary)") }
        
        let films = results.flatMap { (value) -> TMDBFilm? in
            do {
                return try TMDBFilm(dictionary: value)
            } catch let error {
                DLog(error)
            }
            return nil
        }
        return self.init(page: page, films: films)
    }
    
    private struct PopularFilmsResponseFields {
        static let Page = "page"
        static let Results = "results"
    }
}