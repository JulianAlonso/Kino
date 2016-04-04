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
        self.provider.nowPlayingFilms { self.completeAndSaveFilms($0) }
    }
    
    func updateUncomingFilms() {
        self.provider.upcomingFilms { self.completeAndSaveFilms($0) }
    }
    
    // MARK: - Private methods
    private func completeAndSaveFilms(films: [TMDBFilm]) {
        self.provider.completeFilms(films, completion: { (films: [TMDBFilm]) in
            let fullFilms = films.flatMap({ return ($0.isFull()) ? $0 : nil })
            
            self.repository.createOrUpdateObjects(fullFilms, completion: { (inner) in
                do {
                    DLog("✅Saved this films: \(try inner())")
                } catch let error {
                    DLog("‼️Error updating films: \n \(error)")
                }
            })
        })
    }
    
}