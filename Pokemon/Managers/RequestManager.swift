//
//  RequestManager.swift
//  Pokemon
//
//  Created by Oleksii Mykhailenko on 13/11/18.
//  Copyright © 2018 Oleksii Mykhailenko. All rights reserved.
//

import Foundation
import Moya

struct RequestManager {
    
    let provider = MoyaProvider<PokemonAPI>()
    
    func getPokemons<T: Decodable>(completion: @escaping (T) -> (), failure: @escaping (ErrorModel) -> ()) {
        provider.request(.getAllPokemon) { (result) in
            switch result {
            case .success(let response):
                do {
                    let model = try JSONDecoder().decode(T.self, from: response.data)
                    completion(model)
                } catch let error {
                    failure(ErrorModel(errorText: error.localizedDescription))
                }
            case .failure(let error):
                failure(ErrorModel(errorText: error.localizedDescription))
            }
        }
    }
    
}

