//
//  NowPlayingFilmsProvider.swift
//  Kino
//
//  Created by Julian Alonso on 1/12/15.
//  Copyright © 2015 Julian. All rights reserved.
//

import Foundation

class NowPlayingFilmProvider: BaseProvider {
    
    convenience init() {
        self.init(htttpClient: KinoHTTPClient(), defaultParams: Config.apiDefaultParams());
    }
    
    func nowPlayingFilms(completion: FilmArrayCompletion) {
        self.connect(Config[Endpoints.NowPlayingFilmsEndpoint] as! String, params: NSDictionary()) { (inner: Void throws -> NowPlayingFilmsResponse) -> Void in
            do {
                let response = try inner()
                completion(response.films)
            } catch let error {
                DLog(error)
            }
        }
    }
    
}