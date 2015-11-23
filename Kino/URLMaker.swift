//
//  URLMaker.swift
//  Kino
//
//  Created by Julian Alonso on 23/11/15.
//  Copyright © 2015 Julian. All rights reserved.
//

import Foundation

class URLMaker {
    
    private static let basePath = Config[API.BasePath.rawValue]
    
    static func url(endpoint endpoint: String, params: NSDictionary) -> NSURL {
        
        let url = "\(self.basePath)\(endpoint)&api_key=\(params["api_key"] as! String)"
        //TODO: Append params baby 😏
        return NSURL(string: url)!
    }
    
}