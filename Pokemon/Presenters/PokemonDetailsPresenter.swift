//
//  PokemonDetailsPresenter.swift
//  Pokemon
//
//  Created by Oleksii Mykhailenko on 16/11/18.
//  Copyright © 2018 Oleksii Mykhailenko. All rights reserved.
//

import Foundation

protocol PokemonDetailsPresenterProtocol {
    init(view: PokemonDetailsVCProtocol)
    func setupWith(pokemon: Pokemon)
}

class PokemonDetailsPresenter: PokemonDetailsPresenterProtocol {
    
    fileprivate let view: PokemonDetailsVCProtocol
    
    required init(view: PokemonDetailsVCProtocol) {
        self.view = view
    }
    
    func setupWith(pokemon: Pokemon) {
        view.setupLabel(id: pokemon.id)
        view.setupLabel(name: pokemon.name)
        view.setupLabel(height: pokemon.height)
        view.setupLabel(weight: pokemon.weight)
        view.setupLabel(experience: pokemon.base_experience)
        if let url = URL(string: pokemon.sprites.front_default) {
            view.setupImage(url: url)
        }
        
    }
}
