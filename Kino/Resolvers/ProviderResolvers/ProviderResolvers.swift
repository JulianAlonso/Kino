//
//  ProviderResolvers.swift
//  Kino
//
//  Created by Julian Alonso on 21/3/16.
//  Copyright © 2016 Julian. All rights reserved.
//

import Foundation
import Jalver

struct FilmsProviderConfigurator: Configurator {
    
    func configure() -> FilmsProvider {
        return FilmsProvider(httpClient: KinoHTTPClient(), maker: Jalver.resolve(URLMakerDefaultConfigurator))
    }
    
}