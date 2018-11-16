//
//  DefaultsService.swift
//  Pokemon
//
//  Created by Oleksii Mykhailenko on 11/16/18.
//  Copyright © 2018 Oleksii Mykhailenko. All rights reserved.
//

import Foundation

struct DefaultsService {
        
    static func saveBool(_ value: Bool, forKey key: String) {
        UserDefaults.standard.set(value, forKey: key)
    }
    
    static func loadBool(forKey key: String) -> Bool {
        return UserDefaults.standard.bool(forKey: key)
    }
    
}
