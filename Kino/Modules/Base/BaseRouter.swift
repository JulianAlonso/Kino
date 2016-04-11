//
//  BaseRouter.swift
//  Kino
//
//  Created by Julian Alonso on 17/11/15.
//  Copyright © 2015 Julian. All rights reserved.
//

import UIKit

protocol Router {
    var viewController: UIViewController { get }
    var presenter: Presenter { get }
    var navigationController: RoutedNavigationController? { get set }
}

extension Router {
    
    func pushFromNavigationController(navigationController: UINavigationController) {
        navigationController.pushViewController(self.viewController, animated: true)
    }

    func loadViewAtTabBarController(tabBarController: UITabBarController) {
        tabBarController.addChildViewController(self.viewController)
    }
    
}

class BaseRouter<VC: UIViewController, P: Presenter> : Router {
    
    var viewController: UIViewController
    var presenter: Presenter
    
    let realViewController: VC
    let realPresenter: P
    
    var navigationController: RoutedNavigationController?
    
    init(viewController: VC, presenter: P) {
        self.viewController = viewController
        self.presenter = presenter
        
        self.realPresenter = presenter
        self.realViewController = viewController
    }
    
}