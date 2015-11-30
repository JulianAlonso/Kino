//
//  BillboardViewController.swift
//  Kino
//
//  Created by Julian Alonso on 16/11/15.
//  Copyright © 2015 Julian. All rights reserved.
//

import UIKit

protocol BillboardEventHandler {
    
    func updateView()
    
}


class BillboardViewController: BaseViewController {
    
    var eventHandler: BillboardEventHandler?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        self.eventHandler?.updateView()
    }
}
