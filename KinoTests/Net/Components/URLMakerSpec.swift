//
//  URLMakerSpec.swift
//  Kino
//
//  Created by Julian Alonso on 6/7/16.
//  Copyright © 2016 Julian. All rights reserved.
//

import Quick
import Nimble

class URLMakerSpec: QuickSpec {
    
    let host = "http://www.host.com"
    let defaultParams = [ "api_key" : "1234" ]
    let endpoint = "/image"
    let noParams: Dictionary<String, AnyObject> = [:]
    
    var maker: URLMaker!
    
    override func spec() {
        
        describe("URLMakerWithParams") {
            
            beforeEach {
                self.maker = KinoURLMaker(host: self.host, defaultParams: self.defaultParams)
            }
            
            it("returns url without endpoint") {
                let url = self.maker.url("")
                
                expect(url.absoluteString).to(beginWith(self.host))
                expect(url.absoluteString).to(contain("api_key=1234"))
            }
            
            it("returns url with endpoint") {
                let url = self.maker.url(self.endpoint)
                
                expect(url.absoluteString).to(beginWith(self.host + self.endpoint))
                expect(url.absoluteString).to(contain("api_key=1234"))
            }
            
            it ("return url with custom params") {
                let url = self.maker.url("", params: ["param" : 1234])
                
                expect(url.absoluteString).to(beginWith(self.host))
                expect(url.absoluteString).to(contain("param=1234"))
            }
            
            it ("return url with endpoint & custom params") {
                let url = self.maker.url(self.endpoint, params: ["param" : 1234])
                
                expect(url.absoluteString).to(beginWith(self.host + self.endpoint))
                expect(url.absoluteString).to(contain("param=1234"))
            }
        }
        
        describe("URLMaker without params") { 
            
            beforeEach {
                self.maker = KinoURLMaker(host: self.host, defaultParams: self.noParams)
            }
            
            it("return url without endpoint and params") {
                let url = self.maker.url("")
                
                expect(url.absoluteString).to(equal(self.host))
            }
            
            it("return url with endpoint") {
                let url = self.maker.url(self.endpoint)
                
                expect(url.absoluteString).to(equal(self.host + self.endpoint))
            }
            
            it("return url with custom params") {
                let url = self.maker.url("", params: [ "param" : 1234])
                
                expect(url.absoluteString).to(beginWith(self.host))
                expect(url.absoluteString).to(endWith("param=1234"))
            }
            
            it("return url with endpoint & custom params") {
                let url = self.maker.url(self.endpoint, params: [ "param" : 1234])
                
                expect(url.absoluteString).to(beginWith(self.host + self.endpoint))
                expect(url.absoluteString).to(endWith("param=1234"))
            }
        }
        
    }
    
}
