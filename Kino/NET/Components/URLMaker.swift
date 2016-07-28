//
//  URLMaker.swift
//  Kino
//
//  Created by Julian Alonso on 23/11/15.
//  Copyright © 2015 Julian. All rights reserved.
//

import Foundation

protocol URLMaker {
    
    var host: String { get }
    var defaultParams: Dictionary<String, AnyObject> { get }
    
    func url(endpoint: String, params: Dictionary<String, AnyObject>?) -> NSURL
}

extension URLMaker {
    
    func url(endpoint: String, params: Dictionary<String, AnyObject>? = nil) -> NSURL {
        var url = "\(self.host)\(endpoint)"
        if let finalParams = self.params(params) {
            url += "?\(finalParams)"
        }
        return NSURL(string: url)!
    }
    
    func params(params: Dictionary<String, AnyObject>?) -> String? {
        
        var parameters = defaultParams
        
        if let params = params {
            parameters = parameters.reduce(params) { (r: [String : AnyObject], value) -> [String : AnyObject] in
                var w = r
                w[value.0] = value.1
                return w
            }
        }
        
        let components: [(String, String)] = parameters.map { ($0, "\($1)") }
        return (components.count > 0) ? (components.map { "\($0)=\($1)" } as [String]).joinWithSeparator("&") : nil
    }
    
} 