//
//  NetworkService.swift
//  Pokemon
//
//  Created by Oleksii Mykhailenko on 13/11/18.
//  Copyright © 2018 Oleksii Mykhailenko. All rights reserved.
//

import Foundation
import Moya

struct NetworkService {
    
    let provider = MoyaProvider<PokemonAPI>()
    
    func getPokemonsList(completion: @escaping (PokemonList) -> (), failure: @escaping (ServerError) -> ()) {
        provider.request(.getAllPokemon) { (result) in
            switch result {
            case .success(let response):
                do {
                    let model = try JSONDecoder().decode(PokemonList.self, from: response.data)
                    completion(model)
                } catch let error {
                    failure(ServerError(errorMessage: error.localizedDescription,
                                        statusCode: response.statusCode))
                }
            case .failure(let error):
                failure(ServerError(errorMessage: error.localizedDescription,
                                    statusCode: error.response?.statusCode ?? 666))
            }
        }
    }
    
    func getPokemon(name: String, completion: @escaping (PokemonDetails) -> (), failure: @escaping (ServerError) -> ()) {
        provider.request(.getPokemonByName(name: name)) { (result) in
            switch result {
            case .success(let response):
                do {
                    let model = try JSONDecoder().decode(PokemonDetails.self, from: response.data)
                    completion(model)
                } catch let error {
                    failure(ServerError(errorMessage: error.localizedDescription,
                                        statusCode: response.statusCode))
                }
            case .failure(let error):
                failure(ServerError(errorMessage: error.localizedDescription,
                                    statusCode: error.response?.statusCode ?? 666))
            }
        }
    }
}

