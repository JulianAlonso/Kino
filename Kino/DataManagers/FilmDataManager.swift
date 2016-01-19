//
//  FilmDataManager.swift
//  Kino
//
//  Created by Julian Alonso on 7/12/15.
//  Copyright © 2015 Julian. All rights reserved.
//

import Foundation

class FilmDataManager: BaseDataManager<FilmsProvider, FilmRepository> {
    
    init() {
        let filmProvider = FilmsProvider()
        let filmRepository = FilmRepository(mainMOC: CoreDataManager.sharedInstance.readMOC!, backgroundMOC: CoreDataManager.sharedInstance.writerMOC!)
        
        super.init(provider: filmProvider, repository: filmRepository)
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