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
        
        let page = dictionary[PopularFilmsResponseFields.Page] as! Int
        var films: [TMDBFilm] = [TMDBFilm]()
        
        for dictionary in dictionary[PopularFilmsResponseFields.Results] as! [Dictionary<String, AnyObject>] {
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
