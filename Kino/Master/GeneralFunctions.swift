//
//  GeneralFunctions.swift
//  Kino
//
//  Created by Julian Alonso on 16/11/15.
//  Copyright © 2015 Julian. All rights reserved.
//

import Foundation

func DLog(message: Any) {
    #if DEBUG
    print(message)
    #endif
}

// MARK: - Locale functions
func currentCountryCode() -> String {
    return NSLocale.currentLocale().objectForKey(NSLocaleCountryCode) as! String
}