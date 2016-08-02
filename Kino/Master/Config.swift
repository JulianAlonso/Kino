//
//  Config.swift
//  Kino
//
//  Created by Julian Alonso on 23/11/15.
//  Copyright © 2015 Julian. All rights reserved.
//

import Foundation

let Config: ConfigSingleton = ConfigSingleton()

class ConfigSingleton {
    
    subscript(key: Any) -> AnyObject {
        get {
            DLog("Retrieved value: \(Config.valueForKey(String(key))) for key: \(key)")
            return Config.valueForKey(String(key))
        }
    }
    
    private let config: NSDictionary
    
    private init() {
        if let path = NSBundle(forClass: ConfigSingleton.self).pathForResource("Config", ofType: "plist") {
            self.config = NSDictionary(contentsOfFile: path)!
        } else {
            config = NSDictionary()
        }
    }
    
    private func valueForKey(key: String) -> AnyObject {
        return self.config.valueForKey(key)!
    }
    
    // MARK: - Public
    func apiDefaultParams() -> Dictionary<String, AnyObject> {
        return [
            "api_key" : Config[API.ApiKey],
        ]
    }
    
}

// TODO: 🤔Try to do the Config with more Dictionaries with the same name that enums classes🤔
// MARK: - Values
enum API: String {
    case ApiKey
    case BasePath
    case ImageBasePath
}

enum Endpoints : String {
    // MARK: - Films
    case UpcomingFilmsEndpoint
    case NowPlayingFilmsEndpoint
    case PopularFilmsEndpoint
    case SearcFilmshEndpoint
    case FilmByIdEndpoint
    case FilmReleaseDateEndpoint
}

enum TMDBFormats: String {
    case DateFormat
}

