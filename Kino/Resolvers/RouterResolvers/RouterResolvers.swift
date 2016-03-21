//
//  MainRouterResolver.swift
//  Kino
//
//  Created by Julian Alonso on 1/3/16.
//  Copyright © 2016 Julian. All rights reserved.
//

import Foundation
import Jalver

extension MainRouter: Resolver {
    
    static func resolve() -> MainRouter {
        return MainRouter()
    }
    
}

// MARK: -
extension BillboardRouter: Resolver {
    
    static func resolve() -> BillboardRouter {
        let billboardViewController = Jalver.resolve(BillboardViewController)
        let billboardPresenter = Jalver.resolve(BillboardPresenterConfigurator.self) { (inout configurator: BillboardPresenterConfigurator) -> Void in
            configurator.billboardViewController = billboardViewController
        }
        
        return self.init(viewController: billboardViewController, presenter: billboardPresenter)
    }
    
}