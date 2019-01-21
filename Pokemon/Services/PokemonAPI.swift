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
    case getNextPokemons(offset: Int, limit: Int)
    case getPokemonById(id: Int)
    case getPokemonByName(name: String)
}

extension PokemonAPI: TargetType {
    
    var baseURL: URL {
        var currentURL:String = Constants.baseURL
        switch self {
        case .getNextPokemons(let offset, let limit):
            currentURL.append("?offset=\(offset)&limit=\(limit)")
            fallthrough
        default:
            guard let url = URL(string: currentURL) else { fatalError("Error cannot be configured") }
            return url
        }
    }
    
    var path: String {
        switch self {
        case .getNextPokemons(_, _):
            return "pokemon"
        case .getPokemonById(let id):
            return "pokemon/\(id)/"
        case .getPokemonByName(let name):
            return "pokemon/\(name)/"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getNextPokemons, .getPokemonById, .getPokemonByName: return .get
        }
    }
    
    var task: Task {
        switch self {
        case .getNextPokemons, .getPokemonById, .getPokemonByName: return .requestPlain
        }
    }
    
    var headers: [String: String]? {
        return ["Content-type": "application/json"]
    }
    
    var sampleData: Data {
        return "Sample data.".utf8Encoded
    }
}
