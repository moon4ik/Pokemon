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
    let next: Int?
    let previous: Int?
    let results: [PokemonListItem]
}

