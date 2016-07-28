//
//  File.swift
//  Kino
//
//  Created by Julian Alonso on 29/6/16.
//  Copyright © 2016 Julian. All rights reserved.
//

import Quick
import Nimble

class KinoHTTPClientSpec: QuickSpec {
    
    let url = "http://httpbin.org/get"
    let url404 = "http://httpbin.org/status/404"
    let urlUnrecognizedStatus = "http://httpbin.org/status/402"
    
    override func spec() {
        
        var client: HTTPClient!
        
        describe("KinoHTTPClient") { 
            
            beforeEach {
                client = KinoHTTPClient()
            }
            
            it("request a url") {
                
                waitUntil(timeout: 5) { done in
                    client.get(NSURL(string: self.url)!) { (inner: Void throws -> MockResponse) -> (Void) in
                        let object = try! inner()
                        print("object = \(object)")
                        expect(object).to(beTruthy())
                        expect(object.data).to(equal("Data"))
                        done()
                    }
                }
            }
            
            it("request with response status 404") {
                waitUntil(timeout: 5) { done in
                    
                    client.get(NSURL(string: self.url404)!) { (inner: Void throws -> MockResponse) -> (Void) in
                        expect { try inner() }.to(throwError(closure: { (error: HTTPClientError) in
                            expect(error).to(matchError(HTTPClientError.PageNotFound))
                            done()
                        }))
                    }
                    
                }
            }
            
            it("request with response status unrecognized") {
                waitUntil(timeout: 5) { done in
                    
                    client.get(NSURL(string: self.urlUnrecognizedStatus)!) { (inner: Void throws -> MockResponse) -> (Void) in
                        expect { try inner() }.to(throwError(closure: { (error: HTTPClientError) in
                            expect(error).to(matchError(HTTPClientError.DefaultError))
                            done()
                        }))
                    }
                    
                }
            }
        }
    }
    
}

// MARK: - FakeResponse
struct MockResponse : Response {
    
    let data = "Data"
    
    static func from(any: Any) throws -> MockResponse {
        return MockResponse()
    }
    
}