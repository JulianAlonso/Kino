//
//  FilmsProvider.swift
//  Kino
//
//  Created by Julian Alonso on 23/11/15.
//  Copyright © 2015 Julian. All rights reserved.
//

import Foundation

class FilmsProvider: BaseProvider {
    
    convenience init() {
        self.init(htttpClient: KinoHTTPClient(), endpoint: Config[Vars.APIEndPoints.UpcomingFilmsEndpoint.rawValue] as! String, defaultParams: Config.apiDefaultParams());
    }
    
    override init(htttpClient client: HTTPClient, endpoint: String, defaultParams: NSDictionary) {
        super.init(htttpClient: client, endpoint: endpoint, defaultParams: defaultParams)
    }
    
}
