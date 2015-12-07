//
//  Film.swift
//  Kino
//
//  Created by Julian Alonso on 20/11/15.
//  Copyright © 2015 Julian. All rights reserved.
//

import Foundation

struct Film: DomainObject {
    
    let id: String
    let title: String
    let originalLanguage: String
    let originalTitle: String
    let overview: String
    let posterPath: String
    let runtime: Int
    let voteAverage: Double
    let voteCount: Int
    
    init(id: String, title: String, originalLanguage: String, originalTitle: String, overview: String, posterPath: String, runtime: Int, voteAverage: Double, voteCount: Int) {
        self.id = id
        self.title = title
        self.originalLanguage = originalLanguage
        self.originalTitle = originalTitle
        self.overview = overview
        self.posterPath = posterPath
        self.runtime = runtime
        self.voteAverage = voteAverage
        self.voteCount = voteCount
    }
    
}
