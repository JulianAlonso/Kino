//
//  FilmDataManager.swift
//  Kino
//
//  Created by Julian Alonso on 7/12/15.
//  Copyright © 2015 Julian. All rights reserved.
//

import Foundation

final class FilmDataManager: BaseDataManager<FilmsProvider, FilmRepository> {
    
    override init(provider: FilmsProvider, repository: FilmRepository) {
        super.init(provider: provider, repository: repository)
    }
    
    func updateNowPlayingFilms() {
        self.provider.nowPlayingFilms { (films: [TMDBFilm]) -> Void in
            
            let whenCompletedFilmIsReady = { (films: [TMDBFilm]) -> Void in
                self.repository.createOrUpdateObjects(films, completion: { (inner) -> Void in
                    do {
                        DLog("✅Saved this films: \(try inner())")
                    } catch let error {
                        DLog("‼️Error updating films: \n \(error)")
                    }
                })
            };
            
            var completedFilms = [TMDBFilm]()
            for film in films {
                self.provider.completeFilm(film, completion: { (film: TMDBFilm?) -> Void in
                    if let film = film {
                        if film.isFull() {
                            completedFilms.append(film)
                        }
                    }
                    if film == films.last {
                        whenCompletedFilmIsReady(completedFilms)
                    }
                })
            }
            
        }
    }
    
}