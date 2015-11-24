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
    let films: [Film]
    
    init(page: Int, films: [Film]) {
        self.page = page
        self.films = films
    }
    
    static func from(any: Any) throws -> PopularFilmsResponse {
        
        let dictionary = any as! Dictionary<String, AnyObject>
        
        let page = dictionary[PopularFilmsResponseFields.Page.rawValue] as! Int
        var films: [Film] = [Film]()
        
        for dictionary in dictionary[PopularFilmsResponseFields.Results.rawValue] as! [Dictionary<String, AnyObject>] {
            do {
                films.append(try Film.from(dictionary))
            } catch let error {
                DLog(error)
            }
        }
        
        return self.init(page: page, films: films)
    }
    
    private enum PopularFilmsResponseFields: String {
        case Page = "page"
        case Results = "results"
    }
}
