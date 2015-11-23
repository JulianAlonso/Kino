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
    
    func get<T: Response>(url: NSURL, completion: (T) -> (Void)) {
        let session = NSURLSession.sharedSession()
        DLog("URL: \(url)")
        session.dataTaskWithURL(url) { (opData, nsurlResponse, opError) -> Void in
            
            if let data = opData {
                let parsed = self.dictionaryFrom(data)
                if let object = parsed.object {
                    completion(T.from(object))
                } else {
                    completion(T.from(parsed.error!))
                }
            } else if let error = opError {
                completion(T.from(error))
            } else {
                completion(T.from(NSError(domain:HTTPClientError.Domain.rawValue, code: HTTPClientErrorCode.General.rawValue, userInfo: [NSLocalizedDescriptionKey : "\(Self.self) ❌ General error"])))
            }
        }.resume()
    }
    
    func dictionaryFrom(data: NSData) -> (object: AnyObject?, error: NSError?) {
        do {
            let dictionary = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers)
            return (dictionary, nil)
        } catch let error as NSError {
            return (nil, error)
        } catch {
            return (nil, NSError(domain: HTTPClientError.Domain.rawValue, code: HTTPClientErrorCode.Parsing.rawValue, userInfo: [NSLocalizedDescriptionKey: "\(Self.self) ❌ Parsing error"]))
        }
    }
}

enum HTTPClientError: String {
    case Domain = "com.HTTPClient.error"
}

enum HTTPClientErrorCode: Int {
    case General = -50
    case Parsing = -49
}