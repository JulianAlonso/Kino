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
    private let maker: URLMaker
    
    init(httpClient client: HTTPClient, maker: URLMaker) {
        self.client = client
        self.maker = maker
    }
    
    func connect<R: Response>(endpoint: String, params: Dictionary<String, AnyObject>?, completion: (inner: Void throws -> R) -> Void) {
        self.client.get(self.maker.url(endpoint, params: params)) { (inner: Void throws -> R) -> (Void) in
            completion(inner: inner)
        }
    }
}
