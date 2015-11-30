//
//  TMDBFilm.swift
//  Kino
//
//  Created by Julian Alonso on 30/11/15.
//  Copyright © 2015 Julian. All rights reserved.
//

import Foundation

struct TMDBFilm {
    
    let id: String
    let title: String
    let originalLanguage: String
    let originalTitle: String
    let runtime: Int
    let overview: String?
    let posterPath: String?
    let voteAverage: Double?
    let voteCount: Int?
    
    func toFilm() throws -> Film {
        if !self.isFull() { throw Error.NotFull }
        
        return Film(id: self.id,
                    title: self.title,
                    originalLanguage: self.originalLanguage,
                    originalTitle: self.originalTitle,
                    overview: self.overview as String!,
                    posterPath: self.posterPath as String!,
                    runtime: self.runtime as Int!,
                    voteAverage: self.voteAverage as Double!,
                    voteCount: self.voteCount as Int!)
    }
    
    enum Error: ErrorType {
        case NotFull
    }
}

extension TMDBFilm: MayBeFull {
    func isFull() -> Bool {
        return self.overview != nil &&
            self.posterPath != nil &&
            self.voteAverage != nil &&
            self.voteCount != nil
    }
}

extension TMDBFilm: Parseable {
    
    static func from(any: Any) throws -> TMDBFilm {
        if let dictionary = any as? Dictionary<String, AnyObject> {
            return TMDBFilm(dictionary: dictionary)
        }
        
        throw ParseableError.NotRecognizedType("Type \(any.dynamicType) not recognized.")
    }
    
    init(dictionary: Dictionary<String, AnyObject>) {
        
        self.id = String(dictionary[Fields.ID] as! Int)
        self.title = dictionary[Fields.Title] as! String
        self.originalLanguage = dictionary[Fields.OriginalLanguage] as! String
        self.originalTitle = dictionary[Fields.OriginalTitle] as! String
        self.overview = dictionary[Fields.Overview] as? String
        self.posterPath = dictionary[Fields.PosterPath] as? String
        if let runtime = dictionary[Fields.Runtime] as? Int {
            self.runtime = runtime
        } else {
            self.runtime = 0
        }
        self.voteAverage = dictionary[Fields.VoteAverage] as? Double
        self.voteCount = dictionary[Fields.VoteCount] as? Int
        
    }
    
    // MARK: - Film Fields
    struct Fields {
        static let ID = "id"
        static let Title = "title"
        static let OriginalLanguage = "original_language"
        static let OriginalTitle = "original_title"
        static let Overview = "overview"
        static let PosterPath = "poster_path"
        static let BackgropPath = "backgrop_path"
        static let Runtime = "runtime"
        static let VoteAverage = "vote_average"
        static let VoteCount = "vote_count"
    }
}

enum TMDBFilmError: ErrorType {
    case NotRecognizedType(String)
}