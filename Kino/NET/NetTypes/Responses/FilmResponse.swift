//
//  FilmResponse.swift
//  Kino
//
//  Created by Julian Alonso on 1/12/15.
//  Copyright © 2015 Julian. All rights reserved.
//

import Foundation

struct FilmResponse: Response {
    
    let film: TMDBFilm
    
    init(film: TMDBFilm) {
        self.film = film
    }
    
    // MARK: - Parseable
    static func from(any: Any) throws -> FilmResponse {
        let dictionary = any as! Dictionary<String, AnyObject>
        
        return FilmResponse(film: try TMDBFilm(dictionary: dictionary))
    }
}