//
//  FilmsProvider.swift
//  Kino
//
//  Created by Julian Alonso on 23/11/15.
//  Copyright © 2015 Julian. All rights reserved.
//

import Foundation

class FilmsProvider: BaseProvider {
    
    // MARK: - Popular Films Methods
    func popularFilms(completion: FilmArrayCompletion) {
        self.connect(Config[Endpoints.PopularFilmsEndpoint] as! String, params: nil) { (inner: Void throws -> PopularFilmsResponse) -> Void in
            do {
                let response = try inner()
                completion(response.films)
            } catch let error {
                DLog("popularFilms error: \(error)")
            }
        }
    }
    
    // MARK: - Paying Now Film Methods
    func nowPlayingFilms(completion: FilmArrayCompletion) {
        self.connect(Config[Endpoints.NowPlayingFilmsEndpoint] as! String, params: nil) { (inner: Void throws -> NowPlayingFilmsResponse) -> Void in
            do {
                let response = try inner()
                completion(response.films)
            } catch let error {
                DLog("nowPlayingFilms error: \(error)")
            }
        }
    }
    
    // MARK: - Upcoming Film Methods
    func upcomingFilms(completion: FilmArrayCompletion) {
        self.connect(Config[Endpoints.UpcomingFilmsEndpoint] as! String, params: nil) { (inner: Void throws -> UpcomingFilmsResponse) in
            do {
                let response = try inner()
                completion(response.films)
            } catch let error {
                DLog("upcomingFilms error: \(error)")
            }
        }
    }
    
    // MARK: - Complete Film Methods
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
                DLog("completeFilms with name; \(film.title) error: \(error)")
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
                DLog("releaseDatesForFilm with name: \(film.title) error: \(error)")
            }
            completion([TMDBFilmRelease]())
        }
    }
}
