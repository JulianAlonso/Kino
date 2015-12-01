//
//  NowPlayingFilmsResponse.swift
//  Kino
//
//  Created by Julian Alonso on 1/12/15.
//  Copyright © 2015 Julian. All rights reserved.
//

import Foundation

struct NowPlayingFilmsResponse: Response {
    
    let page: Int
    let films: [TMDBFilm]
    
    init(page: Int, films: [TMDBFilm]) {
        self.page = page
        self.films = films
    }
    
    // MARK: - Parseable
    static func from(any: Any) throws -> NowPlayingFilmsResponse {
        
        let dictionary = any as! Dictionary<String, AnyObject>
        
        guard
            let page = dictionary[NowPlayingFilmsResponseFields.Page] as? Int,
            let results = dictionary[NowPlayingFilmsResponseFields.Results] as? [Dictionary<String, AnyObject>]
        else { throw ParseableError.RequiredFieldsNotFound("❌ Required fields not found at \(dictionary)") }
        
        let films = results.flatMap { (value: Dictionary<String, AnyObject>) -> TMDBFilm? in
            do {
                return try TMDBFilm(dictionary: value)
            } catch let error {
                DLog(error)
            }
            return nil
        }
        return self.init(page: page, films: films)
    }
    
    private struct NowPlayingFilmsResponseFields {
        static let Page = "page"
        static let Results = "results"
    }
}