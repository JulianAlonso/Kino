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
    private let defaultParams: NSDictionary
    
    init(httpClient client: HTTPClient, defaultParams: NSDictionary) {
        self.client = client
        self.defaultParams = defaultParams
    }
    
    func connect<R: Response>(endpoint: String, params: NSDictionary?, completion: (inner: Void throws -> R) -> Void) {
        if let params = params {
            DLog("Received params: \(params)")
        }
        self.client.get(URLMaker.url(endpoint: endpoint, params: self.defaultParams)) { (inner: Void throws -> R) -> (Void) in
            completion(inner: inner)
        }
    }
}
