//
//  MockFilmsProviderResolver.swift
//  Kino
//
//  Created by Julian Alonso on 2/8/16.
//  Copyright © 2016 Julian. All rights reserved.
//

import Foundation
import Jalver

struct MockFilmsProviderConfigurator: Configurator {
    
    func configure() -> FilmsProvider {
        return FilmsProvider(httpClient: MockClient(), maker: Jalver.resolve(URLMakerDefaultConfigurator))
    }
    
}