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
    func updateViewController()
}

class PokemonDetailsPresenter: PokemonDetailsPresenterProtocol {
    
    private let view: PokemonDetailsVCProtocol
    private var pokemon: Pokemon?
    
    required init(view: PokemonDetailsVCProtocol) {
        self.view = view
    }
    
    func setupWith(pokemon: Pokemon) {
        self.pokemon = pokemon
    }
    
    func updateViewController() {
        let isReachable = ReachabilityService.isReachable()
        view.isNoDataLabel(show: !isReachable)
        if isReachable, let pokemon = pokemon {
            view.setupTitle(text: pokemon.name)
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
}
