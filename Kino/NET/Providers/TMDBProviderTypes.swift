//
//  TMDBProviderTypes.swift
//  Kino
//
//  Created by Julian Alonso on 1/12/15.
//  Copyright © 2015 Julian. All rights reserved.
//

import Foundation

// MARK: - Films
typealias FilmArrayCompletion = [TMDBFilm] -> Void

typealias OptionalFilmCompletion = TMDBFilm? -> Void

// MARK: - Release Dates
typealias ReleaseDatesCompletion = [TMDBFilmRelease] -> Void