//
//  BillboardPresenter.swift
//  Kino
//
//  Created by Julian Alonso on 16/11/15.
//  Copyright © 2015 Julian. All rights reserved.
//

import UIKit

class BillboardPresenter : BasePresenter, BillboardEventHandler {
    
    let billboardViewController: BillboardViewController
    
    weak var billboardRouter: BillboardRouter?
    
    init(_ billboardViewController: BillboardViewController) {
        self.billboardViewController = billboardViewController
    }
    
}