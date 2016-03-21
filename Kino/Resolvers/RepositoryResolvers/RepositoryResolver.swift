//
//  RepositoryResolver.swift
//  Kino
//
//  Created by Julian Alonso on 21/3/16.
//  Copyright © 2016 Julian. All rights reserved.
//

import Foundation
import Jalver

extension FilmRepository: Resolver {
    
    static func resolve() -> Self {
        return self.init(mainMOC: CoreDataManager.sharedInstance.readMOC!, backgroundMOC: CoreDataManager.sharedInstance.writerMOC!)
    }
    
}