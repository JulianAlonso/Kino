//
//  URLMakerResolver.swift
//  Kino
//
//  Created by Julian Alonso on 11/7/16.
//  Copyright © 2016 Julian. All rights reserved.
//

import Foundation
import Jalver

struct URLMakerDefaultConfigurator: Configurator {
    
    func configure() -> URLMaker {
        return KinoURLMaker(host: Config[API.BasePath] as! String, defaultParams: Config.apiDefaultParams())
    }
    
}