//
//  ViewControllerResolvers.swift
//  Kino
//
//  Created by Julian Alonso on 21/3/16.
//  Copyright © 2016 Julian. All rights reserved.
//

import Foundation
import Jalver

extension BillboardViewController: Resolver {
    
    static func resolve() -> BillboardViewController {
        return BillboardViewController()
    }
    
}