//
//  PokemonsPresenter.swift
//  Pokemon
//
//  Created by Oleksii Mykhailenko on 13/11/18.
//  Copyright © 2018 Oleksii Mykhailenko. All rights reserved.
//

import Foundation
import UIKit

protocol PokemonsPresenterProtocol {
    init(view: PokemonsVCProtocol)
    func numberOfRows(inSection: Int) -> Int
    func configurateCell(cell: PokemonCVCellProtocol, row: Int)
    func loadPokemons()
    func loadMore()
    func didSelectCell(row: Int)
    func limitCount() -> Int
    func changeLimit(grid: GridType)
    func pullToRefresh()
}

class PokemonsPresenter: PokemonsPresenterProtocol {
    
    fileprivate let view: PokemonsVCProtocol
    fileprivate var pokemons = Set<Pokemon>()
    fileprivate var pokemonsArray = Array<Pokemon>()
    fileprivate var pokemonsIds = Array<Int>()
    fileprivate var pokemonList: PokemonList?
    fileprivate var isLoading: Bool = false
    fileprivate let requestService = RequestService()
    fileprivate var limit: Int = 20
    
    //MARK: - PokemonsPresenterProtocol
    
    required init(view: PokemonsVCProtocol) {
        self.view = view
    }
    
    func numberOfRows(inSection: Int) -> Int {
        return pokemons.count
    }
    
    func configurateCell(cell: PokemonCVCellProtocol, row: Int) {
        if row < pokemonsArray.count {
            let pokemon = pokemonsArray[row]
            cell.setupLabel(name: pokemon.name)
            if let url = URL(string: pokemon.sprites.front_default) {
                cell.setupImage(url: url)
            }
        }
    }
    
    func loadPokemons() {
        requestService.getPokemonsList(completion: { [weak self] (pokemonList) in
            self?.pokemonList = pokemonList
            for item in pokemonList.results {
                let stringId: String = item.url.removePrefix(Constants.baseURL+"pokemon/").removeSufix("/")
                let itemId: Int = Int(stringId) ?? 0
                self?.pokemonsIds.append(itemId)
            }
            self?.pokemonsIds.count == pokemonList.count ? print("✅ \(pokemonList.count) ids parsed") : print("🅾️ ids parsed")
            self?.loadMore()
        }) { (serverError) in
            print("ERROR: \(String(describing: serverError.statusCode))  \(String(describing: serverError.errorMessage))")
        }
    }
    
    func loadMore() {
        guard !isLoading else {
            return
        }
        isLoading = true
        let maxCount = pokemonList?.count ?? 0
        let begin = pokemons.count
        let end = (begin + limit) > maxCount ? maxCount : (begin + limit)
        
        print("\(begin) - \(end)")
        if begin < pokemonList?.count ?? 0 {
            var count: Int = 0
            for idx in begin..<end {
                requestService.getPokemonBy(
                    id: pokemonsIds[idx],
                    completion: { [weak self] (pokemon) in
                        guard let `self` = self else { return }
                        count += 1
                        self.pokemons.insert(pokemon)
                        if count == self.limit {
                            self.pokemonsArray = self.pokemons.sorted(by: { (lhs, rhs) -> Bool in
                                lhs.id < rhs.id
                            })
                            self.view.reloadData()
                            self.isLoading = false
                        }
                }) { [weak self] (error) in
                    print("error: \(idx) - pokemonID: \(self?.pokemonsIds[idx] ?? 0)")
                }
            }
        }
    }
    
    func didSelectCell(row: Int) {
        let viewController: PokemonDetailsViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PokemonDetailsViewController") as! PokemonDetailsViewController
        if row < pokemonsArray.count {
            viewController.pokemon = pokemonsArray[row]
        }
        view.present(viewController: viewController)
    }
    
    func limitCount() -> Int {
        return limit
    }
    
    func changeLimit(grid: GridType) {
        switch grid {
        case .two:
            limit = 20
            break
        case .three:
            limit = 30
            break
        case .four:
            limit = 40
            break
        }
    }
    
    func pullToRefresh() {
        //Remove all data
        pokemonsArray.removeAll()
        pokemonList = nil
        pokemonsIds.removeAll()
        pokemons.removeAll()
        //Load new data
        loadPokemons()
    }
}
