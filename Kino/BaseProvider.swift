//
//  BaseProvider.swift
//  Kino
//
//  Created by Julian Alonso on 20/11/15.
//  Copyright © 2015 Julian. All rights reserved.
//

import Foundation

struct BaseProvider {
    
    private let client: HTTPClient
    private let endpoint: String
    private let params: [String]
    
    init(htttpClient client: HTTPClient, endpoint: String, params: [String]) {
        self.client = client
        self.endpoint = endpoint
        self.params = params
    }
    
    
    
}
