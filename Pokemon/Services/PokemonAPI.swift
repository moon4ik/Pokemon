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
    case getAllPokemons
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
        case .getAllPokemons: return "pokemon"
        case .getPokemonById(let id): return "pokemon/\(id)/"
        case .getPokemonByName(let name): return "pokemon/\(name)/"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getAllPokemons, .getPokemonById, .getPokemonByName: return .get
        }
    }
    
    var task: Task {
        switch self {
        case .getAllPokemons, .getPokemonById, .getPokemonByName: return .requestPlain
        }
    }
    
    var headers: [String: String]? {
        return ["Content-type": "application/json"]
    }
    
    var sampleData: Data {
        return "Sample data.".utf8Encoded
    }
    
}
