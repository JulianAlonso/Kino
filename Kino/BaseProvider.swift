//
//  BaseProvider.swift
//  Kino
//
//  Created by Julian Alonso on 20/11/15.
//  Copyright © 2015 Julian. All rights reserved.
//

import Foundation

class BaseProvider {
    
    private let client: HTTPClient
    private let endpoint: String
    private let defaultParams: NSDictionary
    
    init(htttpClient client: HTTPClient, endpoint: String, defaultParams: NSDictionary) {
        self.client = client
        self.endpoint = endpoint
        self.defaultParams = defaultParams
    }

}
