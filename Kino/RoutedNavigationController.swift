//
//  RoutedNavigationController.swift
//  Kino
//
//  Created by Julian Alonso on 17/11/15.
//  Copyright © 2015 Julian. All rights reserved.
//

import UIKit

class RoutedNavigationController: UINavigationController {
    
    var routers = [Router]()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init(router: Router) {
        self.routers.append(router)
        super.init(rootViewController: router.viewController)
    }
    
    func pushRouter(var router: Router) {
        self.routers.append(router)
        router.navigationController = self
        router.pushFromNavigationController(self)
    }
}
