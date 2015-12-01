//
//  FilmsProvider.swift
//  Kino
//
//  Created by Julian Alonso on 23/11/15.
//  Copyright © 2015 Julian. All rights reserved.
//

import Foundation

class PopularFilmsProvider: BaseProvider {
    
    convenience init() {
        self.init(htttpClient: KinoHTTPClient(), defaultParams: Config.apiDefaultParams());
    }
    
    func popularFilms(completion: FilmArrayCompletion) {
        self.connect(Config[Endpoints.PopularFilmsEndpoint] as! String, params: NSDictionary()) { (inner: Void throws -> PopularFilmsResponse) -> Void in
            do {
                let response = try inner()
                completion(response.films)
            } catch let error {
                DLog(error)
            }
        }
    }
}
