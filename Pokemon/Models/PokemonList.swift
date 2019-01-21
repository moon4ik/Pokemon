//
//  PokemonList.swift
//  Pokemon
//
//  Created by Oleksii Mykhailenko on 14/11/18.
//  Copyright © 2018 Oleksii Mykhailenko. All rights reserved.
//

import Foundation

struct PokemonList: Codable {
    let count: Int
    let next: String?
    let previous: String?
    var results: [PokemonListItem]
}

