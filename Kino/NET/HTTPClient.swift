//
//  HTTPClient.swift
//  Kino
//
//  Created by Julian Alonso on 20/11/15.
//  Copyright © 2015 Julian. All rights reserved.
//

import Foundation

protocol HTTPClient {
    
}

extension HTTPClient {
    
    func get<T: Response>(url: NSURL, completion: (inner: () throws -> T) -> (Void)) {
        
        let session = NSURLSession.sharedSession()
        DLog("Request to url: \(url) \n With response type = \(T.self)")
        session.dataTaskWithURL(url) { (data, nsurlResponse, opError) -> Void in
            guard let data = data else { return }
            do {
                let object = try NSJSONSerialization.JSONObjectWithData(data, options: []) as AnyObject
                do {
                    let response = try T.from(object)
                    completion(inner: { return response })
                } catch let error {
                    completion(inner: { throw error })
                }
            } catch let error {
                completion(inner: { throw error })
            }
        }.resume()
    }
}