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
        
        print(MockResponses.UpcomingFilmsResponse.stub())
        
    }
    
}


enum MockResponses: String {
    
    case UpcomingFilmsResponse
    
    func stub() -> String {
        
        let testBundle = NSBundle(forClass: Reference.self)
        let fileURL = testBundle.URLForResource(self.rawValue, withExtension: ".json")
        
        return try! String(contentsOfURL: fileURL!)
    }
    
}

private class Reference {
    
}