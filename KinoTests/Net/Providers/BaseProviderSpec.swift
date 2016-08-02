//
//  BaseProviderSpec.swift
//  Kino
//
//  Created by Julian Alonso on 2/8/16.
//  Copyright © 2016 Julian. All rights reserved.
//

import Quick
import Nimble
import Jalver

class BaseProviderSpec: QuickSpec {
    
    var provider: BaseProvider!
    
    override func spec() {
        
        self.provider = BaseProvider(httpClient: MockClient(), maker: MockURLMaker())
        
        
        describe("Base provider with mockClient and mock url maker") {
            it("Creates a TestingResponse from the received data") {
                waitUntil(timeout: 5, action: { done in
                    self.provider.connect("", params: nil, completion: { (inner: Void throws -> TestingResponse) -> Void in
                        
                        do {
                            let response = try inner()
                            expect(response).to(beTruthy())
                            done()
                        } catch let error {
                            print(error)
                            fail()
                        }
                        
                    })
                })
            }
        }
    }
}

struct TestingResponse: Response {
    
    static func from(any: Any) throws -> TestingResponse {
        return TestingResponse()
    }
    
}
