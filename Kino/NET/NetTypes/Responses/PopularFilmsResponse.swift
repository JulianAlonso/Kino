//
//  PopularFilmsResponse.swift
//  Kino
//
//  Created by Julian Alonso on 24/11/15.
//  Copyright © 2015 Julian. All rights reserved.
//

import Foundation

struct PopularFilmsResponse: Response {
    
    let page: Int
    let films: [TMDBFilm]
    
    init(page: Int, films: [TMDBFilm]) {
        self.page = page
        self.films = films
    }
    
    static func from(any: Any) throws -> PopularFilmsResponse {
        
        let dictionary = any as! Dictionary<String, AnyObject>
        
        guard
            let page = dictionary[PopularFilmsResponseFields.Page] as? Int,
            let results = dictionary[PopularFilmsResponseFields.Results] as? [Dictionary<String, AnyObject>]
        else { throw ParseableError.RequiredFieldsNotFound("❌ Required fields not found at \(dictionary)") }
    
        var films: [TMDBFilm] = [TMDBFilm]()
        
        for dictionary in results {
            do {
                let film = try TMDBFilm.from(dictionary)
                if film.isFull() {
                    films.append(film)
                }
            } catch let error {
                DLog(error)
            }
        }
        
        return self.init(page: page, films: films)
    }
    
    private struct PopularFilmsResponseFields {
        static let Page = "page"
        static let Results = "results"
    }
}
