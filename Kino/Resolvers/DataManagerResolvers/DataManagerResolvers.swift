//
//  DataManagerResolvers.swift
//  Kino
//
//  Created by Julian Alonso on 21/3/16.
//  Copyright © 2016 Julian. All rights reserved.
//

import Foundation
import Jalver

struct FilmDataManagerConfigurator: Configurator {
    
    func configure() -> FilmDataManager {
        return FilmDataManager(provider: Jalver.resolve(FilmsProviderConfigurator.self), repository: Jalver.resolve(FilmRepository))
    }
    
}