//
//  FilmsProvider.swift
//  Kino
//
//  Created by Julian Alonso on 23/11/15.
//  Copyright © 2015 Julian. All rights reserved.
//

import Foundation

typealias CompletionFilmArray = ([Film] -> Void)

class FilmsProvider {
    
    let connector: Connector<Film>
    
//    convenience init() {
//        self.init(htttpClient: KinoHTTPClient(), endpoint: Config[Endpoints.UpcomingFilmsEndpoint.rawValue] as! String, defaultParams: Config.apiDefaultParams());
//    }
//    
//    override init(htttpClient client: HTTPClient, endpoint: String, defaultParams: NSDictionary) {
//        super.init(htttpClient: client, endpoint: endpoint, defaultParams: defaultParams)
//    }
    
    init() {
        self.connector = Connector(htttpClient: KinoHTTPClient(), endpoint: Config[Endpoints.UpcomingFilmsEndpoint.rawValue] as! String, defaultParams: Config.apiDefaultParams())
    }
    
    typealias KinoFilm = KinoResponse<Film>
    
    func popularFilms(completion: CompletionFilmArray) {
        self.connector.connect(NSDictionary()) { (response) -> Void in
            DLog("response = \(response)")
            
            if let films = response.objects {
                completion(films)
            } else {
                completion(Array())
            }
        }
    }
}
