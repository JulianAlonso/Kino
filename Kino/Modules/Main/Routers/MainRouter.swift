//
//  MainRouter.swift
//  Kino
//
//  Created by Julian Alonso on 16/11/15.
//  Copyright © 2015 Julian. All rights reserved.
//

import UIKit

final class MainRouter {
    
    func showMainViewInWindow(window: UIWindow) {
        
        let tabbar = UITabBarController()
        
        let billboardViewController = BillboardViewController()
        let billboardPresenter = BillboardPresenter(billboardViewController)
        
        let billboardRouter = BillboardRouter(viewController: billboardViewController, presenter: billboardPresenter)
        
        let routedNavigationController = RoutedNavigationController(router: billboardRouter)
        
        tabbar.addChildViewController(routedNavigationController)
        
        window.rootViewController = tabbar
        window.makeKeyAndVisible()
    }
    
}