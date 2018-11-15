//
//  PokemonsPresenter.swift
//  Pokemon
//
//  Created by Oleksii Mykhailenko on 13/11/18.
//  Copyright © 2018 Oleksii Mykhailenko. All rights reserved.
//

import Foundation

protocol PokemonsPresenterProtocol {
    init(view: PokemonsVCProtocol)
    func numberOfRows(inSection: Int) -> Int
    func configurateCell(cell: PokemonCVCellProtocol, row: Int)
    func loadPokemons()
}

class PokemonsPresenter: PokemonsPresenterProtocol {
    
    private let view: PokemonsVCProtocol
    var pokemons: Array<Pokemon> = [Pokemon]()
    
    required init(view: PokemonsVCProtocol) {
        self.view = view
    }
    
    func numberOfRows(inSection: Int) -> Int {
        return pokemons.count
    }
    
    func configurateCell(cell: PokemonCVCellProtocol, row: Int) {
        let pokemon = self.pokemons[row]
        cell.setup(name: pokemon.name)
    }
    
    func loadPokemons() {
        let networkService = NetworkService()
        networkService.getPokemonsList(completion: { (pokemonList) in
            for (idx, pokemon) in pokemonList.results.enumerated() {
                networkService.getPokemon(name: pokemon.name,
                                          completion: { (pokemonDetails) in
                                            print(idx)
                },
                                          failure: { (serverError) in
                                            print("ERROR: \(serverError.statusCode ?? 666)  \(serverError.errorMessage ?? "")")
                })
            }
        }) { (serverError) in
            print("ERROR: \(serverError.statusCode ?? 666)  \(serverError.errorMessage ?? "")")
        }
    }
    
    
}
