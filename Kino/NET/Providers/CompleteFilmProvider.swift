//
//  CompleteFilmProvider.swift
//  Kino
//
//  Created by Julian Alonso on 1/12/15.
//  Copyright © 2015 Julian. All rights reserved.
//

import Foundation

class CompleteFilmProvider: BaseProvider {
    
    convenience init() {
        self.init(htttpClient: KinoHTTPClient(), defaultParams: Config.apiDefaultParams());
    }
    
    func completeFilms(films: Array<TMDBFilm>, completion: FilmArrayCompletion) {
        var completedFilms = [TMDBFilm]()
        for film in films {
            self.completeFilm(film, completion: { (completedFilm) -> Void in
                if let completedFilm = completedFilm {
                    completedFilms.append(completedFilm)
                }
                
                if completedFilms.count == films.count {
                    completion(completedFilms)
                }
            })
        }
    }
    
    func completeFilm(film: TMDBFilm, completion: OptionalFilmCompletion) {
        let endpoint = String(format: Config[Endpoints.FilmByIdEndpoint] as! String, film.id)
        self.connect(endpoint, params: nil) { (inner: (Void throws -> FilmResponse)) -> Void in
            do {
                let response = try inner()
                var film = response.film
                
                self.relelaseDatesForFilm(response.film, completion: { (releases) -> Void in
                    film.releaseDates = releases
                    completion(film)
                })
                
            } catch let error {
                DLog(error)
            }
            completion(nil)
        }
    }
    
    func relelaseDatesForFilm(film: TMDBFilm, completion: ReleaseDatesCompletion) {
        let endpoint = String(format: Config[Endpoints.FilmReleaseDateEndpoint] as! String, film.id)
        self.connect(endpoint, params: nil) { (inner: (Void throws -> FilmReleasesResponse)) -> Void in
            do {
                let response = try inner()
                completion(response.releaseDates)
            } catch let error {
                DLog(error)
            }
            completion([TMDBFilmRelease]())
        }
    }
}