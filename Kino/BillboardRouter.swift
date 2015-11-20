//
//  BillboardRouter.swift
//  Kino
//
//  Created by Julian Alonso on 16/11/15.
//  Copyright © 2015 Julian. All rights reserved.
//

import UIKit

class BillboardRouter: BaseRouter<BillboardViewController, BillboardPresenter> {
    
    override init(viewController: BillboardViewController, presenter: BillboardPresenter) {
        super.init(viewController: viewController, presenter: presenter)
    }
    
    func configure() {
        self.realViewController.eventHandler = self.realPresenter
    }
    
    func loadViewAt(tabBarController: UITabBarController) {
        tabBarController.addChildViewController(self.viewController)
    }
    
}