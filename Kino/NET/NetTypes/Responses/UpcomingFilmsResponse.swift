//
//  UpcomingFilmsResponse.swift
//  Kino
//
//  Created by Julian Alonso on 4/4/16.
//  Copyright © 2016 Julian. All rights reserved.
//

import Foundation

struct UpcomingFilmsResponse {
    
    let page: Int
    let films: [TMDBFilm]
    
}

extension UpcomingFilmsResponse: Response {
    
    // MARK: - Parseable
    static func from(any: Any) throws -> UpcomingFilmsResponse {
        
        let dictionary = any as! Dictionary<String, AnyObject>
        
        guard
            let page = dictionary[UpcomingFilmsResponseFields.Page] as? Int,
            let results = dictionary[UpcomingFilmsResponseFields.Results] as? [[String : AnyObject]]
        else { throw ParseableError.RequiredFieldsNotFound("❌ Required fields not found at \(dictionary)") }
        
        let films = results.flatMap { (value: [String : AnyObject]) -> TMDBFilm? in
            do {
                return try TMDBFilm(dictionary: value)
            } catch let error {
                DLog(error)
            }
            return nil
        }
        return self.init(page: page, films: films)
    }
    
    private struct UpcomingFilmsResponseFields {
        static let Page = "page"
        static let Results = "results"
    }
    
}