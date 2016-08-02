//
//  MockClient.swift
//  Kino
//
//  Created by Julian Alonso on 28/7/16.
//  Copyright © 2016 Julian. All rights reserved.
//

import Foundation

struct MockClient: HTTPClient {
    
    func get<T: Response>(url: NSURL, completion: (inner: () throws -> T) -> (Void)) {

        let stub = MockResponses(rawValue: url.absoluteString)!.stub()
        
        do {
            let object = try T.from(stub)
            completion(inner: { return object })
        } catch let error {
            completion(inner: { throw error })
        }
    }
    
}

enum MockResponses: String {
    
    case TestResponse = "http://testing.com/testing"
    case UpcomingFilmsResponse = "http://api.themoviedb.org/3/movie/upcoming?api_key=948b2740eed72ed7447925278587a6d7"
    
    func stub() -> AnyObject {
        
        let testBundle = NSBundle(forClass: Reference.self)
        let fileURL = testBundle.URLForResource(self.responseName(), withExtension: ".json")
        
        return try! NSJSONSerialization.JSONObjectWithData(NSData(contentsOfURL: fileURL!)!, options: NSJSONReadingOptions.MutableContainers)
    }
    
    private func responseName() -> String {
        
        switch self {
            case .UpcomingFilmsResponse:
                return "UpcomingFilmsResponse"
            case .TestResponse:
                return "TestResponse"
        }
        
    }
    
}

private class Reference {
    
}