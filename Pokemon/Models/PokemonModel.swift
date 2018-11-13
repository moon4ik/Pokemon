//
//  PokemonModel.swift
//  Pokemon
//
//  Created by Oleksii Mykhailenko on 14/11/18.
//  Copyright © 2018 Oleksii Mykhailenko. All rights reserved.
//

import Foundation

struct PokemonModel: Decodable {
    let name: String
    let url: String
//    let details: PokemonDetails?
    
    init(name: String, url: String) {
        self.name = name
        self.url = url
    }
}

struct PokemonDetails: Decodable {
    let imageUrl: String
    
    init(imageUrl: String) {
        self.imageUrl = imageUrl
    }
}
