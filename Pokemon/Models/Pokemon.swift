//
//  Pokemon.swift
//  Pokemon
//
//  Created by Oleksii Mykhailenko on 15/11/18.
//  Copyright © 2018 Oleksii Mykhailenko. All rights reserved.
//

import Foundation

struct Pokemon: Codable {
    let id: Int
    let name: String
    let height: Int
    let weight: Int
    let base_experience: Int
    let sprites: Sprites
}

extension Pokemon: Hashable {
    
    static func == (lhs: Pokemon, rhs: Pokemon) -> Bool {
        return lhs.id == rhs.id &&
            lhs.name == rhs.name &&
            lhs.height == rhs.height &&
            lhs.weight == rhs.weight &&
            lhs.base_experience == rhs.base_experience
    }
    
    var hashValue: Int {
        return (id << 48) &+ (height << 32) &+ (weight << 16) &+ base_experience
    }
}
