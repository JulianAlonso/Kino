//
//  FilmsProviderSpec.swift
//  Kino
//
//  Created by Julian Alonso on 2/8/16.
//  Copyright © 2016 Julian. All rights reserved.
//

import Quick
import Nimble
import Jalver

class FilmsProviderSpect: QuickSpec {
    
    let provider = Jalver.resolve(MockFilmsProviderConfigurator)
    
    override func spec() {
        
        describe("FilmsProvider with mock client") {
            
            it("Returns upcoming films from UpcomingFilmsResponse.json") {
                waitUntil(timeout: 5, action: { done in
                    self.provider.upcomingFilms({ (films) in
                        expect(films).to(beTruthy())
                        done()
                    })
                })
            }
        }
    }
    
}

