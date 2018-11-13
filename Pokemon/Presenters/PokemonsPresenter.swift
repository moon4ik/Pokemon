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
    
    private weak let view: PokemonsVCProtocol
    var pokemons = [PokemonModel]()
    
    required init(view: PokemonsVCProtocol) {
        self.view = view
    }
    
    func numberOfRows(inSection: Int) -> Int {
        return pokemons.count
    }
    
    func configurateCell(cell: PokemonCVCellProtocol, row: Int) {
        let pokemon = self.pokemons[row]
        cell.setup(name: pokemon.name)
//        cell.setup(image: UIImage)
    }
    
    func loadPokemons() {
        let requestManager = RequestManager()
        requestManager.getPokemons(completion: { (pokemons: Array<PokemonModel>) in
            print("ARRAY: \(pokemons.count)")
        }) { (error) in
            print("ERROR: \(error)")
        }
    }
    
    
}
