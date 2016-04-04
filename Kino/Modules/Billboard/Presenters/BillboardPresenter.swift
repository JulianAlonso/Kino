//
//  BillboardPresenter.swift
//  Kino
//
//  Created by Julian Alonso on 16/11/15.
//  Copyright © 2015 Julian. All rights reserved.
//

import UIKit

final class BillboardPresenter : BasePresenter, BillboardEventHandler {
    
    let billboardViewController: BillboardViewController
    let filmDataManager: FilmDataManager
    
    
    weak var billboardRouter: BillboardRouter?
    
    init(_ billboardViewController: BillboardViewController, filmDataManager: FilmDataManager) {
        self.billboardViewController = billboardViewController
        self.filmDataManager = filmDataManager
    }
    
    func updateView() {
        self.filmDataManager.updateUncomingFilms()
    }
    
}