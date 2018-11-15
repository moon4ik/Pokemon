//
//  PokemonModel.swift
//  Pokemon
//
//  Created by Oleksii Mykhailenko on 14/11/18.
//  Copyright © 2018 Oleksii Mykhailenko. All rights reserved.
//

import Foundation

struct PokemonList: Codable {
    let count: Int
    let next: String
    let previous: String
    var results: [Pokemon]
}

struct Pokemon: Codable {
    let name: String
    let url: String
    var info: PokemonDetails?
}

struct PokemonDetails: Codable {
    let base_experience: Int
    let height: Int
    let id: Int
    let name: String
    let weight: Int
    let sprites: Sprites
}

struct Sprites: Codable {
    let front_default: String
}
