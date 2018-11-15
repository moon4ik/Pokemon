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
    case getPokemonById(id: Int)
    case getPokemonByName(name: String)
}

extension PokemonAPI: TargetType {
    
    var baseURL: URL {
        guard let url = URL(string: Constants.baseURL) else {
            fatalError("Error cannot be configured")
        }
        return url
    }
    
    var path: String {
        switch self {
        case .getAllPokemon: return "pokemon"
        case .getAllLanguages: return "language"
        case .getPokemonById(let id): return "pokemon/\(id)/"
        case .getPokemonByName(let name): return "pokemon/\(name)/"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getAllPokemon, .getAllLanguages, .getPokemonById, .getPokemonByName:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .getAllLanguages, .getAllPokemon, .getPokemonById, .getPokemonByName:
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
