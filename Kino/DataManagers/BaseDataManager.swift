//
//  BaseDataManager.swift
//  Kino
//
//  Created by Julian Alonso on 7/12/15.
//  Copyright © 2015 Julian. All rights reserved.
//

import Foundation

enum CacheType {
    case NetworkOnly
    case LocalThenNetwork
    case LocalOnly
}

class BaseDataManager<P: BaseProvider, R: Repository> {
    
    let provider: P
    let repository: R
    
    init(provider: P, repository: R) {
        self.provider = provider
        self.repository = repository
    }
    
}