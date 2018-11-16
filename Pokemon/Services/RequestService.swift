//
//  RequestService.swift
//  Pokemon
//
//  Created by Oleksii Mykhailenko on 13/11/18.
//  Copyright © 2018 Oleksii Mykhailenko. All rights reserved.
//

import Foundation
import Moya

struct RequestService {
    
//    let provider = MoyaProvider<PokemonAPI>(plugins: [NetworkLoggerPlugin(verbose: true)])
    let provider = MoyaProvider<PokemonAPI>()
    
    /// Get list of all pokemons only with name and url
    ///
    /// - Parameters:
    ///   - completion: completion return PokemonList model
    ///   - failure: return ServerError model
    func getPokemonsList(completion: @escaping (PokemonList) -> (), failure: @escaping (ServerError) -> ()) {
        provider.request(.getAllPokemons) { (result) in
            switch result {
            case .success(let response):
                do {
                    let model = try JSONDecoder().decode(PokemonList.self, from: response.data)
                    completion(model)
                } catch let error {
                    Logger.write("ERROR \(response.statusCode) - \(error.localizedDescription)")
                    failure(ServerError(errorMessage: error.localizedDescription,
                                        statusCode: response.statusCode))
                }
            case .failure(let error):
                Logger.write("ERROR \(String(describing: error.response?.statusCode)) - \(error.localizedDescription)")
                failure(ServerError(errorMessage: error.localizedDescription,
                                    statusCode: error.response?.statusCode ?? 0))
            }
        }
    }
    
    
    /// Request of Pokemon detail information
    ///
    /// - Parameters:
    ///   - name: Pokemon's name
    ///   - completion: completion return Pokemon model
    ///   - failure: return ServerError model
    func getPokemonBy(name: String, completion: @escaping (Pokemon) -> (), failure: @escaping (ServerError) -> ()) {
        provider.request(.getPokemonByName(name: name)) { (result) in
            switch result {
            case .success(let response):
                do {
                    let model = try JSONDecoder().decode(Pokemon.self, from: response.data)
                    completion(model)
                } catch let error {
                    Logger.write("ERROR \(response.statusCode) - \(error.localizedDescription)")
                    failure(ServerError(errorMessage: error.localizedDescription,
                                        statusCode: response.statusCode))
                }
            case .failure(let error):
                Logger.write("ERROR \(String(describing: error.response?.statusCode)) - \(error.localizedDescription)")
                failure(ServerError(errorMessage: error.localizedDescription,
                                    statusCode: error.response?.statusCode ?? 0))
            }
        }
    }
    
    
    /// Request of Pokemon detail information
    ///
    /// - Parameters:
    ///   - id: Pokemon's id
    ///   - completion: completion return Pokemon model
    ///   - failure: return ServerError model
    func getPokemonBy(id: Int, completion: @escaping (Pokemon) -> (), failure: @escaping (ServerError) -> ()) {
        provider.request(.getPokemonById(id: id)) { (result) in
            switch result {
            case .success(let response):
                do {
                    let model = try JSONDecoder().decode(Pokemon.self, from: response.data)
                    completion(model)
                } catch let error {
                    Logger.write("ERROR \(response.statusCode) - \(error.localizedDescription)")
                    failure(ServerError(errorMessage: error.localizedDescription,
                                        statusCode: response.statusCode))
                }
            case .failure(let error):
                Logger.write("ERROR \(String(describing: error.response?.statusCode)) - \(error.localizedDescription)")
                failure(ServerError(errorMessage: error.localizedDescription,
                                    statusCode: error.response?.statusCode ?? 0))
            }
        }
    }
}

