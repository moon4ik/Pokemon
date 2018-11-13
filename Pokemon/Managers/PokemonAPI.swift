//
//  PokemonAPI.swift
//  Pokemon
//
//  Created by Oleksii Mykhailenko on 13/11/18.
//  Copyright © 2018 Oleksii Mykhailenko. All rights reserved.
//

import Foundation
import Moya

enum PokemonAPI {
    case getAllPokemon
    case getAllLanguages
}

extension PokemonAPI: TargetType {
    
    var baseURL: URL {
        guard let url = URL(string: "https://pokeapi.co/api/v2") else {
            fatalError("Error cannot be configured")
        }
        return url
    }
    
    var path: String {
        switch self {
        case .getAllPokemon:
            return "/pokemon"
        case .getAllLanguages:
            return "/language"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getAllPokemon, .getAllLanguages:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .getAllLanguages, .getAllPokemon:
            return .requestPlain
        }
    }
    
    var headers: [String: String]? {
        return ["Content-type": "application/json"]
    }
    
    var sampleData: Data {
        return "I don't know why.".utf8Encoded
    }
    
}

private extension String {
    var utf8Encoded: Data {
        return data(using: .utf8)!
    }
}
