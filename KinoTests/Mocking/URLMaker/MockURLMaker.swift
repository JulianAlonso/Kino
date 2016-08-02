//
//  MockURLMaker.swift
//  Kino
//
//  Created by Julian Alonso on 2/8/16.
//  Copyright © 2016 Julian. All rights reserved.
//

import Foundation

struct MockURLMaker: URLMaker {
    
    var host: String
    var defaultParams: Dictionary<String, AnyObject>
    
    init() {
        self.host = ""
        self.defaultParams = [:]
    }
    
    func url(endpoint: String, params: Dictionary<String, AnyObject>?) -> NSURL {
        return NSURL(string: "http://testing.com/testing")!
    }
    
}
