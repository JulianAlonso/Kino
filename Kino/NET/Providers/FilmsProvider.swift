//
//  FilmsProvider.swift
//  Kino
//
//  Created by Julian Alonso on 23/11/15.
//  Copyright © 2015 Julian. All rights reserved.
//

import Foundation

typealias CompletionFilmArray = ([TMDBFilm] -> Void)

class FilmsProvider: BaseProvider {
    
    convenience init() {
        self.init(htttpClient: KinoHTTPClient(), endpoint: Config[Endpoints.PopularFilmsEndpoint] as! String, defaultParams: Config.apiDefaultParams());
    }
    
    override init(htttpClient client: HTTPClient, endpoint: String, defaultParams: NSDictionary) {
        super.init(htttpClient: client, endpoint: endpoint, defaultParams: defaultParams)
    }
    
    func popularFilms(completion: CompletionFilmArray) {
        self.connect(NSDictionary()) { (inner: Void throws -> PopularFilmsResponse) -> Void in
            do {
                let response = try inner()
                completion(response.films)
            } catch let error {
                DLog(error)
            }
        }
    }
}
