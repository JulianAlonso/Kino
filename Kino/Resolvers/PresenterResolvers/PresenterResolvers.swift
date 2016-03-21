//
//  PresenterResolvers.swift
//  Kino
//
//  Created by Julian Alonso on 21/3/16.
//  Copyright © 2016 Julian. All rights reserved.
//

import Foundation
import Jalver

struct BillboardPresenterConfigurator: Configurator {
    
    var billboardViewController: BillboardViewController!
    
    func configure() -> BillboardPresenter {
        return BillboardPresenter(self.billboardViewController, filmDataManager: Jalver.resolve(FilmDataManagerConfigurator))
    }
    
}