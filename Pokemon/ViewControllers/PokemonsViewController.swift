//
//  PokemonsViewController.swift
//  Pokemon
//
//  Created by Oleksii Mykhailenko on 12/11/18.
//  Copyright © 2018 Oleksii Mykhailenko. All rights reserved.
//

import UIKit

protocol PokemonsVCProtocol {
    func reloadData()
}

class PokemonsViewController: UIViewController {

    var presenter: PokemonsPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setup(presenter: PokemonsPresenter(view: self))
    }

    func setup(presenter: PokemonsPresenterProtocol) {
        self.presenter = presenter
    }
}

